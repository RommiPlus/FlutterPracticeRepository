import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      home: CustomWidget(),
    ));

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(body: Signature());
}

class Signature extends StatefulWidget {
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox referenceBox = context.findRenderObject();
          Offset localPosition =
          referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)
            ..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: CustomPaint(
        painter: SignaturePainter(_points),
        size: Size.infinite,
        child: Center(
            child: Text('a painter child',
                style: TextStyle(color: Colors.redAccent))),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(SignaturePainter other) => other.points != points;
}

class CustomWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomState();
  }
}

class CustomState extends State<CustomWidget> {
  var width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 300,
            child: Center(
              child: Text('data'),
            ),
          ),
          CustomPaint(
              painter: CustomPaintTranslucent(),
              size: Size(MediaQuery
                  .of(context)
                  .size
                  .width, 300))
        ],
      ),
    );
  }
}

class CustomPaintTranslucent extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0x4f000000)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, 300)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
