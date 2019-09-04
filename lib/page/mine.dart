import 'package:flutter/material.dart';
import 'package:amap_location/amap_location.dart';
import 'package:permission_handler/permission_handler.dart';

class MinePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new MinePageWidget(),
    );
  }
}

class MinePageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _PageState();
  }

}

class _PageState extends State<MinePageWidget> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  AMapLocation _location;

  @override
  void initState() {
    super.initState();

    requestPermission();
    //AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));

  }

  @override
  void dispose() {
    //注意这里关闭
    //AMapLocationClient.shutdown();
    super.dispose();
  }

  Widget _cell(int row, IconData iconData, String title, String describe, bool isShowBottomLine) {
    return GestureDetector(
      onTap: () {
        switch (row) {
          case 0:
            print("$row -- $title");
            break;
          case 1:
            print("$row -- $title");
            break;
          case 2:
            print("$row -- $title");
            break;
          case 3:
            print("$row -- $title");
            break;
          case 4:
            print("$row -- $title");
            break;
          case 5:
            print("$row -- $title");
            break;
          case 6:
            print("$row -- $title");
            break;
        }
      },
      child: new Container(

        height: 50.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                margin: new EdgeInsets.all(0.0),
                height: (isShowBottomLine ? 49.0 : 50.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(left: 15.0),
                        child: new Row(
                          children: <Widget>[
                            new Icon(iconData, color: Colors.brown),
                            new Container(
                              margin: new EdgeInsets.only(left: 15.0),
                              child: new Text(title, style: TextStyle(color: Color(0xFF777777), fontSize: 16.0)),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        child: new Row(
                          children: <Widget>[
                            new Text(describe, style: TextStyle(color: Color(0xFFD5A670), fontSize: 14.0)),
                            new Icon(Icons.keyboard_arrow_right, color: Color(0xFF777777)),
                          ],
                        ),
                      ),
                    ]
                )
            ),

            _bottomLine(isShowBottomLine),

          ],
        ),
      ),
    );
  }

  Widget _bottomLine(bool isShowBottomLine) {
    if (isShowBottomLine) {
      return new Container(
          margin: new EdgeInsets.all(0.0),
          child: new Divider(
              height: 1.0,
              //color: Colors.black
          ),
          padding: EdgeInsets.only(left: 15.0, right: 15.0)
      );
    }
    return Container();
  }

  Widget _spaceView() {
    return Container(
      height: 10.0,
      //color: Colors.black,
    );
  }

  Widget _topView(String name, String phone) {
    return new GestureDetector(
      onTap: () {
        print("修改头像、姓名、电话");
      },
      child: new Container(
        height: 180.0,
        color: Colors.lightBlue,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Container(
              height: 40.0,
              width: 40.0,
              alignment: Alignment.center,
              margin: new EdgeInsets.only(right: 20.0, top: 10.0),
              child: new IconButton(
                  iconSize: 20.0,
                  icon: new Icon(Icons.new_releases, color: Colors.white),
                  onPressed: () {
                    print("查看消息");
                  }),
            ),
            new Container(
              height: 90.0,
              margin: new EdgeInsets.only(top: 20.0),
//              color: Colors.yellow,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.only(left: 15.0),
                      child: new Card(
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(new Radius.circular(35.0))
                        ),
                        child: new Image.asset("images/icon_tabbar_mine_normal.png", height: 70.0, width: 70.0),
                      )
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 8.0, top: 25.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text("userName", style: TextStyle(color: Color(0xFF777777), fontSize: 18.0), textAlign: TextAlign.left),
                        new Text("mobile", style: TextStyle(color: Color(0xFF555555), fontSize: 12.0), textAlign: TextAlign.left)
                      ],
                    ),
                  ),
                  new Container(
                    child: new Icon(Icons.keyboard_arrow_right, color: Color(0xFF777777)),
                    margin: new EdgeInsets.only(left: MediaQuery.of(context).size.width/ 2 - 15.0),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  //创建一个扫描二维码的方法
  scan() async {
    try {

      AMapLocation tlocation = await getLocation();
      setState(() {
        _location = tlocation;
      });




    } catch (e) {
      print('$e');
    }
  }


  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.locationAlways]);

    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationAlways);

    if (permission == PermissionStatus.granted) {
      print("权限申请通过");
    } else {
      print("权限申请通过");
    }
  }



  //创建定位的方法
  Future<AMapLocation> getLocation() async {
    //先启动定位工具
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyBest));
    //获取定位
    AMapLocation location = await AMapLocationClient.getLocation(true);
    if (location.code == 12) {

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('提示'),
            content: Text('请打开GPS定位按钮'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('确定'))
            ],
          ));

    }
    return location;
  }

  @override
  Widget build(BuildContext context) {

    super.build(context); //要点3


    return new Material(
      child: new Container(
        //color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _topView("阴天不尿尿", "13146218612");
            } else if (index == 1) {
              return _cell(index, Icons.list, "我的专属顾问", "xxxx" , true);
            } else if (index == 2) {
              return _cell(index, Icons.card_membership, "银行卡", "", true);
            }  else if (index == 3) {
              return _cell(index, Icons.title, "风险评测", "", false);
            } else if (index == 4) {
              return _spaceView();
            } else if (index == 5) {
              return new Center(
                child: _location == null
                    ? new Text("正在定位")
                    : new Text("定位成功: 省:${_location.province} 市:${_location.city} 区:${_location.district} 街道:${_location.street} "),
              );
            }  else if (index == 6) {
              return  new SizedBox(
                  height: 100,
                  width: 200,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: scan,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Text(
                      '地理位置',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),

                  ));
            } else {



              return new Container(
                height: MediaQuery.of(context).size.height,
                //color: Colors.black,
              );
            }
          },
          itemCount: 6 + 1,
        ),
      ),
    );
  }
}