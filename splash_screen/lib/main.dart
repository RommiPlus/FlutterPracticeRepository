import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }

}

class MyAppState extends State<HomeWidget> {

  @override
  void initState() {
    super.initState();

    splashToHome();
  }

  splashToHome() {
   return new Timer(Duration(seconds: 3), () => toHomePage());
  }

  toHomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('splash screen'),
    );
  }

}

class HomePageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Center(
        child: Text('hello world'),
      ),
    );
  }

}

