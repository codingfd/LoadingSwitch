import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultEmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("暂无数据",style: TextStyle(fontSize: 24),),
    );
  }
}
