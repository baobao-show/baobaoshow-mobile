import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:baobao/model/video.dart';
import 'package:baobao/widget/waiting.dart';

class VideoCard extends StatelessWidget {

  final VideoModel video;

  VideoCard({this.video});

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
                  backgroundImage: NetworkImage(video.head),
                  radius: 20.0,
                  // maxRadius: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 250,
                  child: Text(
                    video.name,
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
              video.record,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: new ChewiePlayer(url:video.url),
          )
        ],
      ),
    );
  }
}

class ChewiePlayer extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final String url;
  final bool looping;

  ChewiePlayer({
    @required this.url,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewiePlayerState createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =  VideoPlayerController.network(
      widget.url,
    )
      ..initialize().then((_) {

        setState(() {

        });
      });



    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController:_videoPlayerController,
      aspectRatio: 3 / 2,
      // Prepare the video to be played and display the first frame
      //autoInitialize: true,
      looping: true,
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
          child: WaitingCard(),
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


      _videoPlayerController?.pause()?.then((v) {

        Future.delayed(Duration(seconds: 1));

        _chewieController?.dispose();

        _videoPlayerController?.dispose();

      });

      print('控制器销毁');
    }


    super.dispose();
  }
}
