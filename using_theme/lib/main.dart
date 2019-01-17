import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const MaterialColor appbarColor = MaterialColor(
      0xff4ab156,
      <int, Color>{
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(0xff4ab156),
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF0D47A1),
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: appbarColor,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Using Theme'),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Text(
            'hello world!',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 24
            ),
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.pinkAccent),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}

