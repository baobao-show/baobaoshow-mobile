import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:baobao/model/video.dart';

class VideoService {
  static Future<String> loadAsset() async {

    await new Future.delayed(new Duration(milliseconds: 500));
    return await rootBundle.loadString('assets/json/video.json');
  }

  static Future<VideoListModel> loadJson() {

    return loadAsset().then((value) {

      JsonDecoder decoder = new JsonDecoder();
      List<dynamic> json = decoder.convert(value);

      VideoListModel v = VideoListModel.fromJson(json);

      return v;
    });
  }
}
