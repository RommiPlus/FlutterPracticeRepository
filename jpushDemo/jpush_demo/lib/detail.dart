import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jpush_demo/main.dart';

class DetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {
  StreamSubscription subscription;
  String text = '这是极光推送跳转页面';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情页面')),
      body: Center(
        child: Text(text),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<OnNotificationReceiveEvent>().listen((event) {
      if(mounted) {
        setState(() {
          text = '详情页面用户可见状态：接收到了通知';
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
  }
}
