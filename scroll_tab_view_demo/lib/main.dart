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
  List<Widget> _tabs = List();
  List<Widget> _content = List();
  final directionsCar = [
    Tab(text: 'This is a text'),
    Tab(icon: Icon(Icons.directions_bike)),
    Tab(icon: Icon(Icons.directions_railway)),
    Tab(icon: Icon(Icons.directions_car)),
  ];

  @override
  void initState() {
    super.initState();
    List<Widget> tempTabs = List();
    tempTabs.addAll(directionsCar);

    List<Widget> tempContent = List();
    tempContent.addAll(buildTabView());

    _tabs = tempTabs;
    _content = tempContent;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              key: PageStorageKey(5),
              tabs: _tabs,
              isScrollable: true,
            ),
          ),
          body: TabBarView(children: _content),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                List<Widget> tempTabs = List();
                tempTabs.addAll(directionsCar);

                List<Widget> tempContent = List();
                tempContent.addAll(buildTabView());
                setState(() {
                  _tabs = tempTabs;
                  _content = tempContent;
                });
              },
              child: Icon(Icons.add)),
        ));
  }

  List<Widget> buildTabView() {
    final view = [
      buildListView(1),
      buildListView(2),
      buildListView(3),
      buildListView(4),
    ];
    return view;
  }

  ListView buildListView(int i) {
    return ListView.builder(
        key: PageStorageKey(i),
        itemBuilder: (context, index) {
          return Text('item: $index', style: TextStyle(fontSize: 16));
        },
        itemCount: 100);
  }
}
