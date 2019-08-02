import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:baobao/model/ablum.dart';
import 'dart:async';


class AblumService {
  static Future<String> loadAsset() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    return await rootBundle.loadString('assets/json/ablum.json');
  }

  static Future<AblumListModel> loadJson(int currentPage, int pageSize) {
    return loadAsset().then((value) {
      JsonDecoder decoder = new JsonDecoder();
      List<dynamic> json = decoder.convert(value);

      AblumListModel v = AblumListModel.fromJson(
              json.skip(currentPage * pageSize).take(pageSize).toList());

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

class AblumListViewModel extends BaseViewModel<AblumListModel> {
  List<AblumModel> storyList = List();
  int _currentPage = 0;
  int _pageSize = 3;

  Stream<List<AblumModel>> get outStoryList => outputData.map((videoLis) {

    print(videoLis.items);
    storyList.addAll(videoLis.items);
    return storyList;
  });


  refreshStoryList() async {
    _currentPage = 0;
    storyList.clear();
    AblumListModel model = await AblumService.loadJson(_currentPage, _pageSize);
    inputData.add(model);
  }

  loadNextPage() async {
    _currentPage++;
    AblumListModel model = await AblumService.loadJson(_currentPage, _pageSize);
    inputData.add(model);
  }

  fetchStoryList() {
    _currentPage = 0;
    return AblumService.loadJson(_currentPage, _pageSize).then((value){

      inputData.add(value);

      return value;
    });

  }

}

