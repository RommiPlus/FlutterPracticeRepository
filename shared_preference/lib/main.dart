import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var count = 0;

  @override
  void initState() {
    super.initState();

    initCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$count',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              child: Text('Increment Counter'),
              onPressed: incrementCount,
            ),
            RaisedButton(
              child: Text('Decrement Counter'),
              onPressed: decrementCount,
            )
          ],
        ),
      ),
    );
  }

  incrementCount() {
    setState(() {
      count++;
      saveData2Preference();
    });
  }

  decrementCount() {
    setState(() {
      count--;
      saveData2Preference();
    });
  }

  loadDataFromPreference() async {
    final pres = await SharedPreferences.getInstance();
    count = (pres.getInt('counter') ?? 0);
  }

  void saveData2Preference() async {
    final pres = await SharedPreferences.getInstance();
    pres.setInt('counter', count);
  }

  initCount() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Get value
      count = (prefs.getInt('counter') ?? 0);
    });
  }
}
