import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:amap_location/amap_location.dart';



import 'package:baobao/intro.dart';

//void main() => runApp(MyApp());
void main() {

  AMapLocationClient.setApiKey("fe39ecff3d66d0ce0c9e1453503231c0");

  runApp(new MyApp());
  if (defaultTargetPlatform == TargetPlatform.android) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }


}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //showPerformanceOverlay: true, // 开启
      home: IntroPage(),
      theme: ThemeData(primaryColor: Colors.lightBlue),
    );
  }
}


