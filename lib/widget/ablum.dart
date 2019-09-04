import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:baobao/model/ablum.dart';
import 'package:share/share.dart';

class AblumCard extends StatelessWidget {
  final AblumModel ablum;

  AblumCard({this.ablum});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(ablum.head),
                  radius: 20.0,
                  // maxRadius: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,//
                    //在水平方向上，这个Row占据的大小
                    mainAxisSize: MainAxisSize.max,//默认值  尽可能多占据
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Text('作者：',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              )),
                          Text('HuYounger',
                              style: TextStyle(
                                color: Colors.redAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      )),
                      //收藏图标
                      Padding(
                        child: Icon(Icons.favorite, color: Colors.red),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                      //分享图标
                      new IconButton(
                        icon: new Icon(Icons.share, color: Colors.black),
                        onPressed: () {
                          Share.share(
                              'check out my website https://example.com');
                        },
                      )


                    ],
                  ),
                )
              ],
            ),
          ),
          Container(child: new Divider()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              ablum.record,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 5),
            color: Colors.black12,
            child: CachedNetworkImage(
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              imageUrl: ablum.cover,
            ),
          ),
        ],
      ),
    );
  }
}
