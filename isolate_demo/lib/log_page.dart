import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isolate_demo/data_sync.dart';

class LogPageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LogPageState();
  }
}

class LogPageState extends State<LogPageWidget> {
  String receiveData = 'no data init';

  @override
  void initState() {
    super.initState();
    callerCreateIsolate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('log page')),
      body: Text(receiveData),
      floatingActionButton: FloatingActionButton(onPressed: onPress),
    );
  }

  void onPress() async {
    receiveData = await sendReceive("this is main isolate messge");
    setState(() {

    });
  }
}
