import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTree(),
    );
  }
}

/// 嵌套的控件
class MyInherited extends InheritedWidget {
  final MyInheritedWidgetState data;

  MyInherited({Key key, @required Widget child, @required this.data})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class Item {
  String reference;

  Item(this.reference);
}

/// widget
class MyInheritedWidget extends StatefulWidget {
  final Widget child;

  MyInheritedWidget({
    Key key,
    this.child,
  }) : super(key: key);

  static MyInheritedWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MyInherited) as MyInherited)
        .data;
  }

  @override
  State<StatefulWidget> createState() {
    return MyInheritedWidgetState();
  }
}

/// widget state
class MyInheritedWidgetState extends State<MyInheritedWidget> {
  List _items = List();

  int get itemsCount => _items.length;

  void addItem(String reference) {
    setState(() {
      _items.add(Item(reference));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInherited(child: widget.child, data: this);
  }
}

class MyTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTreeState();
  }
}

class MyTreeState extends State<MyTree> {
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: Scaffold(
        body: Column(
          children: <Widget>[Text('this is a test data'), WidgetA(), WidgetB()],
        ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return Container(
      child: RaisedButton(
          child: Text('Add Item'),
          onPressed: () {
            state.addItem('new item');
          }),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return Text('${state.itemsCount}');
  }
}
