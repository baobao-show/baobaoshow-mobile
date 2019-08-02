import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:baobao/model/ablum.dart';

class AblumService {
  static Future<String> loadAsset() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    return await rootBundle.loadString('assets/json/ablum.json');
  }

  static Future<List<AblumModel>> loadJson(int currentPage, int pageSize) {
    return loadAsset().then((value) {
      JsonDecoder decoder = new JsonDecoder();
      List<dynamic> json = decoder.convert(value);

      print(currentPage);

      List<AblumModel> v = AblumListModel.fromJson(
              json.skip(currentPage * pageSize).take(pageSize).toList())
          .items;

      return v;
    });
  }
}
