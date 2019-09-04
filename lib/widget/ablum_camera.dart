import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';



class PhotoCamera extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<PhotoCamera> {
  Future<File> _imageFile;

  double _screenWidth() {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //键盘弹出时将不会resize
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding:false,

      appBar: AppBar(

        centerTitle: true,

        title: new Text('发布照片'),
        actions: <Widget>[
          // 非隐藏的菜单
          FlatButton(
            textColor: Colors.white,
            onPressed: () {},
            child: Text("保存"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
                maxHeight: 90.0,
                maxWidth: _screenWidth(),
                minHeight: 30.0,
                minWidth: _screenWidth()),
            margin: EdgeInsets.all(5.0),
            child: TextField(
              maxLines: 2,
              maxLength: 150,
              keyboardType: TextInputType.multiline,
              //给TextField设置装饰（形状等）
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[100])),
                //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                contentPadding: EdgeInsets.all(10.0),
                fillColor: Colors.grey[100], filled: true,
                //
                hintText: '心情印记。。。。。。', //默认的文字placeholder 占位文字
                // 以下属性可用来去除TextField的边框
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                // border:InputBorder.none,  去掉那条线
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: 180.0,
                maxWidth: _screenWidth(),
                minHeight: 180.0,
                minWidth: _screenWidth()),
            margin: EdgeInsets.all(5.0),
            // alignment: Alignment.bottomRight,
            alignment: Alignment(0, 0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 1.0),
                  color: Colors.grey[100],
                  blurRadius: 25.0,
                  spreadRadius: -9.0,
                ),
              ],
            ),
            // color: Color.fromRGBO(3, 54, 255, 1.0),
            child: _ImageView(),
          ),
          Container(
              margin: EdgeInsets.all(5.0),
              constraints: BoxConstraints(
                  maxHeight: 40.0,
                  maxWidth: _screenWidth(),
                  minHeight: 40.0,
                  minWidth: _screenWidth()),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: _takePhoto,
                      child: Text("拍照"),
                      color: Colors.blue,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                    ),

                    flex: 1,
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: _openGallery,
                      child: Text("选择照片"),
                      color: Colors.blue,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    flex: 1,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /*图片控件*/
  Widget _ImageView() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return new ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(snapshot.data, fit: BoxFit.cover),
            );
          } else {
            return new Image.asset("assets/images/white.jpg",
                height: 200.0, width: 400.0);
          }
        });
  }

  /*拍照*/
  _takePhoto() async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  /*相册*/
  _openGallery() async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
}

