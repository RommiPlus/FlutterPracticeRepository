import 'package:flutter/material.dart';
import 'package:sqlite_db_sample/pages/home_page.dart';
import 'package:sqlite_db_sample/pages/login.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/second': (context) => HomePage(),
    },
  ));
}

