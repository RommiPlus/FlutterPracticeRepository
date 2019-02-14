import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/logo_title.jpg'),
          Container(
            margin: const EdgeInsets.all(32),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Oeschinen Lake Campground',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(margin: EdgeInsets.only(top: 4)),
                      Text('Kandersteg, Switzeland')
                    ],
                  ),
                ),
                Icon(Icons.star, color: Colors.redAccent),
                Text('41')
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(children: <Widget>[
                  Icon(Icons.call, color: Colors.blue),
                  Text('CALL', style: TextStyle(color: Colors.blue))
                ]),
                Column(children: <Widget>[
                  Icon(Icons.send, color: Colors.blue),
                  Text('ROUTE', style: TextStyle(color: Colors.blue))
                ]),
                Column(children: <Widget>[
                  Icon(Icons.share, color: Colors.blue),
                  Text('SHARE', style: TextStyle(color: Colors.blue))
                ]),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
                'The button section contains 3 columns that use the same layout—an icon over a row of text. The columns in this row are evenly spaced, and the text and icons are painted with the primary color. Since the code for building each column is almost identical, create a private helper method named buildButtonColumn(), which takes a color, an Icon and Text, and returns a column with its widgets painted in the given color.'),
          )
        ],
      ),
    );
  }
}
