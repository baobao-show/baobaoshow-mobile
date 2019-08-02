import 'package:flutter/material.dart';
import 'package:async/src/async_memoizer.dart';

import 'package:baobao/service/ablum.dart';
import 'package:baobao/model/ablum.dart';
import 'package:baobao/widget/ablum.dart';
import 'package:baobao/widget/camera.dart';
import 'package:baobao/widget/waiting.dart';

class AblumPage extends StatelessWidget {
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
                          child: new PhotoCamera()));
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
  int _currentPage = 0;
  int _pageSize = 3;

  ScrollController _scrollController =
      new ScrollController(); // 初始化滚动监听器，加载更多使用

  List<AblumModel> temp = [];
  Future<List<AblumModel>> listAblum;

  @override
  bool get wantKeepAlive => true; //要点2

  @override
  void initState() {
    setState(() {
      listAblum = _getFristData();
    });

    _scrollController.addListener(() {
      // 如果滑动到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("下拉到底了");

        _getMoreData();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //要点3

    return new RefreshIndicator(
      child: new FutureBuilder(
        future: listAblum,
        builder: _buildFuture,
      ),
      onRefresh: _refresh,
    );
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:

        //return  CircularProgressIndicator();
        return WaitingCard();

      case ConnectionState.done:
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            return new ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return new AblumCard(ablum: snapshot.data[index]);
              },
            );
          }
        }
        break;
      default:
        return WaitingCard();
    }
  }

  Future<List<AblumModel>> _getMoreData() async {
    _currentPage = _currentPage + 1;
    return AblumService.loadJson(_currentPage, _pageSize).then((value) {

      setState(() {
        temp.addAll(value);
      });

      return temp;
    });
  }

  Future<List<AblumModel>> _getFristData() async {
    _currentPage = 0;
    return AblumService.loadJson(_currentPage, _pageSize).then((value) {
      temp.addAll(value);
      return temp;
    });
  }

  Future _refresh() async {
    temp.clear();

    setState(() {
      listAblum = _getFristData();
    });
  }
}
