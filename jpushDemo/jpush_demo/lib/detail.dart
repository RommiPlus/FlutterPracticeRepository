import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情页面')),
      body: Center(
        child: Text('这是极光推送跳转页面'),
      ),
    );
  }
}
