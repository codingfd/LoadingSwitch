import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_switch/loading_switch.dart';

class DefaultErrorPage extends StatelessWidget {
  final OnWidgetTap onWidgetTap;

  DefaultErrorPage({this.onWidgetTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "网络错误",
          style: TextStyle(fontSize: 24),
        ),
        FlatButton(
          color: Colors.lightBlue,
          child: Text("点击重新加载"),
          onPressed: () {
            if (onWidgetTap != null) {
              onWidgetTap(LoadingStatus.error.toString());
            }
          },
        ),
      ],
    ));
  }
}
