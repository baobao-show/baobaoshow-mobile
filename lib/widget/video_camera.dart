import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


class VideoCamera extends StatefulWidget {

  VideoCamera({Key key}):super(key:key);
  _VideoCameraState createState() => _VideoCameraState();
}

class _VideoCameraState extends State<VideoCamera> {
  Future <File> _imageFile;

  VideoPlayerController _controller;//视频播放器
  VoidCallback listener;//闭包 or block

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(listener);
      }


        ImagePicker.pickVideo(source: source).then((File file){
          if (file != null && mounted) {
            setState(() {
              _controller = VideoPlayerController.file(file)
                ..addListener(listener)
                ..setVolume(1.0)//音量
                ..initialize()//初始化(异步)
                ..setLooping(true)//循环播放
                ..play();
            });
          }
        });

    });
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(1.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listener = (){
      setState(() {});
    };
  }


  Widget _previewVideo(VideoPlayerController controller) {
    if (controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  double _screenWidth() {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,

        title: new Text('发布视频'),
        actions: <Widget>[
          // 非隐藏的菜单
          FlatButton(
            textColor: Colors.white,
            onPressed: () {},
            child: Text("保存"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              maxHeight: 450.0,
              maxWidth: _screenWidth(),
              minHeight: 280.0,
              minWidth: _screenWidth()),
          margin: EdgeInsets.all(5.0),
          // alignment: Alignment.bottomRight,
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 1.0),
                color: Colors.grey[100],
                blurRadius: 25.0,
                spreadRadius: -9.0,
              ),
            ],
          ),
          // color: Color.fromRGBO(3, 54, 255, 1.0),
          child:  _previewVideo(_controller),
        ),
        Container(
            margin: EdgeInsets.all(5.0),
            constraints: BoxConstraints(
                maxHeight: 40.0,
                maxWidth: _screenWidth(),
                minHeight: 40.0,
                minWidth: _screenWidth()),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {

                      _onImageButtonPressed(ImageSource.gallery);
                    },
                    child: Text("相册选取视频"),
                    color: Colors.blue,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                  ),

                  flex: 1,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {

                    _onImageButtonPressed(ImageSource.camera);
                    },
                    child: Text("视频录制"),
                    color: Colors.blue,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  flex: 1,
                ),
              ],
            )),
      ],
    ),
//      floatingActionButton: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(top: 16.0),
//            //'从相册选取视频'
//            child: FloatingActionButton(
//              backgroundColor: Colors.red,
//              onPressed: () {
//
//                _onImageButtonPressed(ImageSource.gallery);
//              },
//              child: const Icon(Icons.video_library),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(top: 16.0),
//            //视频录制
//            child: FloatingActionButton(
//              backgroundColor: Colors.red,
//              onPressed: () {
//
//                _onImageButtonPressed(ImageSource.camera);
//              },
//              child: const Icon(Icons.videocam),
//            ),
//          ),
//
//
//        ],
//      ),
    );
  }
}



class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;
  AspectRatioVideo(this.controller);
  _AspectRatioVideoState createState() => _AspectRatioVideoState();
}

class _AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = (){
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
      return Center(
        child: AspectRatio(
          aspectRatio: size.width / size.height,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}