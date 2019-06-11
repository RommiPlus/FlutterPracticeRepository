import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_demo/detail.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

void main() {
  runApp(MyApp());
}

class OnNotificationReceiveEvent {}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
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
  MethodChannel channel = MethodChannel('pageControl');
  JPush _jpush = new JPush();

  @override
  void initState() {
    super.initState();

    print('init state');

    _jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
        eventBus.fire(OnNotificationReceiveEvent());
      },

      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        if (mounted) {
          print('gogogog $mounted');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetailPage()));
        } else {
          print('gogogog $mounted');
        }
      },

      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );

    _jpush.setup(
      appKey: 'd9d82e487ae2452f38da2dc0',
      production: false,
      // 设置是否打印 debug 日志
      debug: true,
    );

    _jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    _jpush.getLaunchAppNotification().then((map) {
      print(map);
      if (mounted) {
        print('gogogog $mounted');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailPage()));
      } else {
        print('gogogog $mounted');
      }
    });

    _jpush.getRegistrationID().then((rid) {
      print('registration id: $rid');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage();
              }));
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
        onWillPop: () {
          // 使用原生函数将应用返回到后台
          channel.invokeMethod('toBackGround', true);

          // 拦截返回事件
          return Future.value(false);
        });
  }
}
