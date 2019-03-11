
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondPage extends StatefulWidget {
  final String name;

  SecondPage(this.name);

  SecondPage.create() : name = 'data';

  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }

}

class SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page title'),
      ),
      body: Text(widget.name ?? 'no data'),
      floatingActionButton: FloatingActionButton(onPressed: callback),
    );
  }


  void callback() {
    Navigator.pop(context, widget.name);
  }
}