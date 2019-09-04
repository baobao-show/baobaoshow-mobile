import 'package:flutter/material.dart';
import 'package:async/src/async_memoizer.dart';

import 'package:baobao/service/ablum.dart';
import 'package:baobao/model/ablum.dart';
import 'package:baobao/widget/ablum.dart';
import 'package:baobao/widget/ablum_camera.dart';
import 'package:baobao/widget/waiting.dart';

class AblumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            // showModalBottomSheet  半屏
            // showBottomSheet   全屏
            //
            showBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) {
                  return new Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.only(top: 20),
                      child:
                           new PhotoCamera());
                });
          },
          child: Icon(
            Icons.photo_camera,
          ),
        ),
        title: new Text('AblumPage'),
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
  AblumListViewModel videoListViewModel = AblumListViewModel();
  ScrollController _scrollController =
  new ScrollController(); // 初始化滚动监听器，加载更多使用

  @override
  bool get wantKeepAlive => true; //要点2

  @override
  Widget build(BuildContext context) {
    super.build(context); //要点3

    return new StreamBuilder<List<AblumModel>>(

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

                  return new AblumCard(ablum: stories[index]);
                },
              ));
        }
        else{
          return FinishCard();
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

