import 'package:flutter/material.dart';

//import 'package:baobao/page/ablum.dart';
//import 'package:baobao/page/video.dart';
//import 'package:baobao/page/mine.dart';


import 'package:baobao/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //showPerformanceOverlay: true, // 开启
      home: MainPage(),
      theme: ThemeData(primaryColor: Colors.lightBlue),
    );
  }
}


//
//class ScaffoldPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => new PageState();
//}
//
//class PageState extends State<ScaffoldPage> with SingleTickerProviderStateMixin {
//
//
//  int _currentIndex = 0;
//  final List<Widget> _children = [AblumPage(), VideoPage(), MinePage()];
//
//  final List<BottomNavigationBarItem> _list = <BottomNavigationBarItem>[
//    BottomNavigationBarItem(
//      icon: Icon(Icons.photo_library),
//      title: Text('纪念册'),
//      //backgroundColor: Colors.orange
//    ),
//    BottomNavigationBarItem(
//      icon: Icon(Icons.live_tv),
//      title: Text('留声机'),
//      //backgroundColor: Colors.orange
//    ),
//    BottomNavigationBarItem(
//      icon: Icon(Icons.person),
//      title: Text('专属地'),
//      //backgroundColor: Colors.orange
//    )
//  ];
//
//  @override
//  void initState() {
//
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.fixed,
//        onTap: onTabTapped,
//        currentIndex: _currentIndex,
//        items: _list,
//      ),
//
//      body: IndexedStack(
//        index: _currentIndex,
//        children: _children,
//      ),
//    );
//  }
//
//  void onTabTapped(int index) {
//    setState(() {
//      _currentIndex = index;
//    });
//  }
//
//
//
//}
