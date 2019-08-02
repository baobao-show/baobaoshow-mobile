import 'package:flutter/material.dart';

import 'package:baobao/service/video.dart';
import 'package:baobao/model/video.dart';
import 'package:baobao/widget/video.dart';
import 'package:baobao/widget/camera.dart';
import 'package:baobao/widget/waiting.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: InkWell(
          onTap: () {
            // showModalBottomSheet<T>：显示模态质感设计底部面板
            showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new Container(
                      child: new Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: new VideoCamera()));
                });
          },
          child: Icon(
            Icons.videocam,
          ),
        ),
        title: new Text('VideoPage'),
      ),
      body: new JsonView(),
    );
  }
}

class JsonView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _JsonViewState();
  }
}

class _JsonViewState extends State<JsonView>   with AutomaticKeepAliveClientMixin {
  Future<VideoListModel> ablumList;

  @override
  bool get wantKeepAlive => true;//要点2


  @override
  Widget build(BuildContext context) {

    super.build(context);//要点3

    return new FutureBuilder(
      future: ablumList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return  WaitingCard();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.hasData) {


                return new ListView.builder(
                  itemCount: snapshot.data.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data.items[index].name);

                    return new VideoCard(video: snapshot.data.items[index]);

                  },
                );
              }
            }
            break;
          default:
            new CircularProgressIndicator();
        }
      },
    );
  }

  Future<VideoListModel> _getData() {

     return  VideoService.loadJson();

  }

  @override
  void initState() {

    setState(() {
      ablumList = _getData();
    });

    super.initState();
  }
}
