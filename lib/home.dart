import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


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
    return  Scaffold(
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
    );
  }

  @override
  void initState() {
    super.initState();
    //申请APP依赖的权限
    requestPermission();
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


  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {
      print("storage权限申请通过");
    } else {
      print("storage权限申请通过");
    }


    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions2 =
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);

    // 申请结果
    PermissionStatus permission2 = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera);

    if (permission2 == PermissionStatus.granted) {
      print("camera权限申请通过");
    } else {
      print("camera权限申请通过");
    }


    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions3 =
    await PermissionHandler().requestPermissions([PermissionGroup.locationAlways]);

    // 申请结果
    PermissionStatus permission3 = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationAlways);

    if (permission3 == PermissionStatus.granted) {
      print("locationAlways权限申请通过");
    } else {
      print("locationAlways权限申请通过");
    }


  }


}
