import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:baobao/home.dart';

class IntroPage extends StatelessWidget {


  final pages =[
    PageViewModel(
        pageColor: Colors.blueAccent,
        mainImage: Image.asset('assets/images/1.jpg'),
        title: Text('第一页'),
        body: Text('海浪里的海鸥')
    ),
    PageViewModel(
        pageColor: Colors.blueAccent,
        mainImage: Image.asset('assets/images/2.jpg'),
        title: Text('第二页'),
        body: Text('海滩的海鸥')
    ),
    PageViewModel(
        pageColor: Colors.blueAccent,
        mainImage: Image.asset('assets/images/3.jpg'),
        title: Text('第三页'),
        body: Text('村边的海鸥')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开场动画',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: Builder(
        builder: (context)=>IntroViewsFlutter(
          pages,
          onTapDoneButton: (){
            //路由跳转
            Navigator.of(context).pushReplacementNamed('/page1');
          },
          showSkipButton: true,
          skipText: Text('跳过'),
          doneText: Text('完成'),
          pageButtonTextStyles: TextStyle(
              fontSize: 18.0,
              color: Colors.white
          ),
        ),
      ),
      routes: <String,WidgetBuilder>{
        '/page1':(BuildContext context)=>new MainPage()		//NewPage就是自己写的一个页面
      },
    );
  }
}