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
  Status status = Status.cold;

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
            CustomSwitch(
              status: status,
              onStatusChanged: (status) {
                setState(() {
                  this.status = status;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum Status {
  cold,
  warm,
  wind,
  stop,
}

typedef OnStatusChanged = void Function(Status staus);

class CustomSwitch extends StatefulWidget {
  final Status status;
  final OnStatusChanged onStatusChanged;

  const CustomSwitch({Key key, this.status, this.onStatusChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomSwitchState();
  }
}

class CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(
          color: Color(0xfff4fafa),
          border: Border.all(color: Color(0xffcbeced)),
          borderRadius: BorderRadius.circular(6))),
      width: 200,
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ToggleButton(
            status: widget.status == Status.cold
                ? SelectStatus.checked
                : SelectStatus.unchecked,
            text: '冷气',
            callback: () {
              widget.onStatusChanged(Status.cold);
            },
          ),
          ToggleButton(
            status: widget.status == Status.warm
                ? SelectStatus.checked
                : SelectStatus.unchecked,
            text: '暖气',
            callback: () {
              widget.onStatusChanged(Status.warm);
            },
          ),
          ToggleButton(
            status: widget.status == Status.wind
                ? SelectStatus.checked
                : SelectStatus.unchecked,
            text: '冷气',
            callback: () {
              widget.onStatusChanged(Status.wind);
            },
          ),
          ToggleButton(
            status: widget.status == Status.stop
                ? SelectStatus.checked
                : SelectStatus.unchecked,
            text: '停止',
            callback: () {
              widget.onStatusChanged(Status.stop);
            },
          ),
        ],
      ),
    );
  }
}

enum SelectStatus { checked, unchecked }

class ToggleButton extends StatelessWidget {
  final SelectStatus status;
  final String text;
  final VoidCallback callback;

  const ToggleButton({Key key, this.status, this.text, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.all(0),
      minWidth: 40,
      height: 24,
      child: FlatButton(
          color: getBgColor(),
          disabledColor: getBgColor(),
          child: Text(text, style: TextStyle(color: getTextColor())),
          onPressed: status == SelectStatus.checked ? null : callback),
    );
  }

  Color getBgColor() {
    return status == SelectStatus.checked
        ? Color(0xff26b7bc)
        : Color(0xfff4fafa);
  }

  Color getTextColor() {
    return status == SelectStatus.checked
        ? Color(0xffffffff)
        : Color(0xffb0b1b2);
  }
}
