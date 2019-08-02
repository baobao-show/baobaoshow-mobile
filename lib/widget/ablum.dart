import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:baobao/model/ablum.dart';

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
                  child: Text(
                    ablum.name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
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
            color: Colors.black12,
            child: CachedNetworkImage(
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              imageUrl: ablum.cover,
            ),
          ),
          Container(child: new Divider())
        ],
      ),
    );
  }
}
