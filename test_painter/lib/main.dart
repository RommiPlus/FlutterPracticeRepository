// import 'package:flutter/material.dart';
// import 'package:test_painter2/painter2.dart';
// import 'dart:typed_data';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'myGesture.dart';
// import 'package:flutter_drag_scale/flutter_drag_scale.dart';
// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Painter2 Example',
//       home: ExamplePage(),
//     );
//   }
// }

// class ExamplePage extends StatefulWidget {
//   @override
//   _ExamplePageState createState() => new _ExamplePageState();
// }

// class _ExamplePageState extends State<ExamplePage> {
//   bool _finished;
//   PainterController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _finished = false;
  //   _controller = newController();
  // }

  // PainterController newController() {
  //   PainterController controller = PainterController();
  //   controller.thickness = 5.0;
  //   controller.backgroundColor = Colors.green;
  //   controller.backgroundImage = Image.network(
  //       'https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a9e671b9a551f3dedcb2bf64a4eff0ec/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg');
  //   return controller;
  // }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> actions;
//     if (_finished) {
//       actions = <Widget>[
//         IconButton(
//           icon: Icon(Icons.content_copy),
//           tooltip: 'New Painting',
//           onPressed: () => setState(() {
//                 _finished = false;
//                 _controller = newController();
//               }),
//         ),
//       ];
//     } else {
//       actions = <Widget>[
//         IconButton(
//           icon: Icon(Icons.undo),
//           tooltip: 'Undo',
//           onPressed: () {
//             if (_controller.canUndo) _controller.undo();
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.redo),
//           tooltip: 'Redo',
//           onPressed: () {
//             if (_controller.canRedo) _controller.redo();
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.delete),
//           tooltip: 'Clear',
//           onPressed: () => _controller.clear(),
//         ),
//         IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () async {
//               setState(() {
//                 _finished = true;
//               });
//               Uint8List bytes = await _controller.exportAsPNGBytes();
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (BuildContext context) {
//                 return Scaffold(
//                   appBar: AppBar(
//                     title: Text('View your image'),
//                   ),
//                   body: Container(
//                     child: Image.memory(bytes),
//                   ),
//                 );
//               }));
//             }),
//       ];
//     }
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('Painter2 Example'),
//           actions: actions,
//           bottom: PreferredSize(
//             child: DrawBar(_controller),
//             preferredSize: Size(MediaQuery.of(context).size.width, 30.0),
//           )),
//       body: Center(
//           child: AspectRatio(aspectRatio: 1.0, child: Painter(_controller))),
//     );
//   }
// }

// class DrawBar extends StatelessWidget {
//   final PainterController _controller;

//   DrawBar(this._controller);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Flexible(child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//           return Container(
//               child: Slider(
//             value: _controller.thickness,
//             onChanged: (value) => setState(() {
//                   _controller.thickness = value;
//                 }),
//             min: 1.0,
//             max: 20.0,
//             activeColor: Colors.white,
//           ));
//         })),
//         ColorPickerButton(_controller, false),
//         ColorPickerButton(_controller, true),
//       ],
//     );
//   }
// }

// class ColorPickerButton extends StatefulWidget {
//   final PainterController _controller;
//   final bool _background;

//   ColorPickerButton(this._controller, this._background);

//   @override
//   _ColorPickerButtonState createState() => new _ColorPickerButtonState();
// }

// class _ColorPickerButtonState extends State<ColorPickerButton> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(_iconData, color: _color),
//       tooltip:
//           widget._background ? 'Change background color' : 'Change draw color',
//       onPressed: () => _pickColor(),
//     );
//   }

//   void _pickColor() {
//     Color pickerColor = _color;
//     Navigator.of(context)
//         .push(MaterialPageRoute(
//             fullscreenDialog: true,
//             builder: (BuildContext context) {
//               return Scaffold(
//                   appBar: AppBar(
//                     title: Text('Pick color'),
//                   ),
//                   body: Container(
//                       alignment: Alignment.center,
//                       child: ColorPicker(
//                         pickerColor: pickerColor,
//                         onColorChanged: (Color c) => pickerColor = c,
//                       )));
//             }))
//         .then((_) {
//       setState(() {
//         _color = pickerColor;
//       });
//     });
//   }

//   Color get _color => widget._background
//       ? widget._controller.backgroundColor
//       : widget._controller.drawColor;

//   IconData get _iconData =>
//       widget._background ? Icons.format_color_fill : Icons.brush;

//   set _color(Color color) {
//     if (widget._background) {
//       widget._controller.backgroundColor = color;
//     } else {
//       widget._controller.drawColor = color;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'flutter_drag_scale.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool editMode = false;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(children: <Widget>[
      Container(
      height: 600.0,
      width: 400,
      child: Center(
        child: DragScaleContainer(
          editMode: editMode,
          doubleTapStillScale: true,
          child: new Image(
            image: new NetworkImage(
                'http://pic15.nipic.com/20110809/2852987_102440194840_2.jpg'),
          ),
        ),
      ),
    ),
    // GestureDetector(
    //   child:Container(width: 400, height:100,color: Colors.red),
    //   onTap:(){
    //     setState(() {
    //       editMode = !editMode;
    //     });
    //     print("${editMode?"编辑模式":"缩放模式"}");
    //   }
    // )

    
    ],
    ),
    
    );
  }
}

