import 'dart:convert';
import 'dart:async';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:baobao/model/video.dart';

class VideoService {
  static Future<String> loadAsset() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    return await rootBundle.loadString('assets/json/video.json');
  }

  static Future<VideoListModel> loadJson(int currentPage, int pageSize) {
    return loadAsset().then((value) {
      JsonDecoder decoder = new JsonDecoder();
      List<dynamic> json = decoder.convert(value);

      VideoListModel v = VideoListModel.fromJson(
              json.skip(currentPage * pageSize).take(pageSize).toList())
          ;
      print(currentPage);
      return v;
    });
  }
}



abstract class BaseViewModel<T> {
  var _dataSourceController = StreamController<T>.broadcast();

  Sink get inputData => _dataSourceController;

  Stream get outputData => _dataSourceController.stream;

  dispose() {
    _dataSourceController.close();
  }
}

class VideoListViewModel extends BaseViewModel<VideoListModel> {
  List<VideoModel> storyList = List();
  int _currentPage = 0;
  int _pageSize = 3;

  Stream<List<VideoModel>> get outStoryList => outputData.map((videoLis) {

    print(videoLis.items);
    storyList.addAll(videoLis.items);
    return storyList;
  });


  refreshStoryList() async {
    _currentPage = 0;
    storyList.clear();
    VideoListModel model = await VideoService.loadJson(_currentPage, _pageSize);
    inputData.add(model);
  }

  loadNextPage() async {
    _currentPage++;
    VideoListModel model = await VideoService.loadJson(_currentPage, _pageSize);
    inputData.add(model);
  }

  fetchStoryList() {
    _currentPage = 0;
    return VideoService.loadJson(_currentPage, _pageSize).then((value){

      inputData.add(value);

      return value;
    });

  }

}

