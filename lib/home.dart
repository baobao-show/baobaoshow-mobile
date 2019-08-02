import 'package:flutter/material.dart';

import 'package:baobao/page/ablum.dart';
import 'package:baobao/page/video.dart';
import 'package:baobao/page/mine.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  PageController pageController;
  int page = 0;

  final bodyList = [AblumPage(), VideoPage(), MinePage()];
  final items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.photo_library),
      title: Text('纪念册'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.live_tv),
      title: Text('留声机'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('专属地'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: new PageView(
        children: bodyList,
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: onTap,
        currentIndex: page,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
