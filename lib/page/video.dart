import 'package:flutter/material.dart';
import 'dart:async';

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

class _JsonViewState extends State<JsonView>
    with AutomaticKeepAliveClientMixin {
  VideoListViewModel videoListViewModel = VideoListViewModel();
  ScrollController _scrollController =
      new ScrollController(); // 初始化滚动监听器，加载更多使用

  @override
  bool get wantKeepAlive => true; //要点2

  @override
  Widget build(BuildContext context) {
    super.build(context); //要点3

    return new StreamBuilder<List<VideoModel>>(

      stream: videoListViewModel.outStoryList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        List stories = snapshot.data;

        if (stories != null) {
          return RefreshIndicator(
              onRefresh: () {
                return videoListViewModel.refreshStoryList();
              },
              child: new ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: (stories?.length ?? 0) + 1,
                itemBuilder: (BuildContext context, int index) {

                  if (index >= (stories?.length ?? 0)) {
                    //storyListViewModel.loadNextPage();
                    return WaitingCard();
                  }

                  return new VideoCard(video: stories[index]);
                },
              ));
        }
        else{
          return WaitingCard();
        }


      },
    );
  }

  @override
  void initState() {


    videoListViewModel.fetchStoryList();

    _scrollController.addListener(() {
      // 如果滑动到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("下拉到底了");
        videoListViewModel.loadNextPage();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    videoListViewModel.dispose();
  }
}
