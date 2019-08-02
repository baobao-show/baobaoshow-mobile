
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:baobao/model/video.dart';


class VideoCard extends StatefulWidget {


  final VideoModel video;

  VideoCard({this.video});


  @override
  State<StatefulWidget> createState() {
    return new VideoCardState();
  }
}

class VideoCardState extends State<VideoCard> {


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.video.head),
                  radius: 20.0,
                  // maxRadius: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 250,
                  child: Text(
                    widget.video.name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.video.record,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ChewiePlayer(
              videoPlayerController: VideoPlayerController.network(
                widget.video.url,
              ),
              looping: true,

            ),

          Container(child: new Divider())
        ],
      ),
    );
  }
}



class ChewiePlayer extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewiePlayer({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewiePlayerState createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 3 / 2,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },

      placeholder: Container(
        color: Colors.grey,
        child: Center(
          child: Text("正在努力加载中..."),
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
        controller: _chewieController,

    );
  }

  @override
  void dispose() {

    //为了满足全屏时候 控制器不被直接销毁 判断只有不是全屏的时候 才允许控制器被销毁
    if (_chewieController != null && !_chewieController.isFullScreen) {
      widget.videoPlayerController.dispose();
      _chewieController.dispose();

      print('控制器销毁');

    }

    super.dispose();

  }
}