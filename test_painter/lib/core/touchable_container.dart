library painter;
// import 'package:flutter/material.dart';
import './custom_gesture_detector.dart' as gd;


import 'package:flutter/material.dart' as mat show Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' hide Image;
import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';


class ScaleChangedModel {
  double scale;
  Offset offset;
  ScaleChangedModel({this.scale, this.offset});

  @override
  String toString() {
    return 'ScaleChangedModel(scale: $scale, offset:$offset)';
  }
}

class TouchableContainer extends StatefulWidget {
  final Widget child;
  final bool doubleTapStillScale;
  bool editMode;
  ///用来约束图和坐标轴的
  ///因为坐标轴和图是堆叠起来的，图在坐标轴的内部，需要制定margin，否则放大后图会超出坐标轴
  final EdgeInsets margin;
  ValueChanged<ScaleChangedModel> scaleChanged;


//-------------> painter2
final PainterController painterController;




  TouchableContainer(
    PainterController painterController,
      {this.child,
      EdgeInsets margin,
      this.scaleChanged,
      this.doubleTapStillScale,
      this.editMode})
      : this.margin = margin ?? EdgeInsets.all(0),this.painterController = painterController,
        super(key: ValueKey<PainterController>(painterController));
  _TouchableContainerState createState() => _TouchableContainerState();
}

class _TouchableContainerState extends State<TouchableContainer>
    with SingleTickerProviderStateMixin {
  double _kMinFlingVelocity = 800.0;
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;
  Offset doubleDownPositon;




//----------------> painter2
final GlobalKey _globalKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);

      widget.painterController._globalKey = _globalKey;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  //也就是最小值是原点0，0，点从最大值到0的区间，也就是这个图可以从最大值移动到原点
  Offset _clampOffset(Offset offset) {
    final Size size = context.size; //容器的大小
    final Offset minOffset =
        new Offset(size.width, size.height) * (1.0 - _scale);
    return new Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(gd.ScaleStartDetails details) {
    print("_handleOnScaleStart");
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(gd.ScaleUpdateDetails details) {
        print("_handleOnScaleUpdate");

    setState(() {
      if (details.pointCount > 1) {
        print("进到这里了");
        _scale = (_previousScale * details.scale).clamp(1.0, double.infinity);
      }
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
    ScaleChangedModel model =
        new ScaleChangedModel(scale: _scale, offset: _offset);
    if (widget.scaleChanged != null) widget.scaleChanged(model);
  }

  void _handleOnScaleEnd(gd.ScaleEndDetails details) {
        print("_handleOnScaleEnd");

    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = new Tween<Offset>(
            begin: _offset, end: _clampOffset(_offset + direction * distance))
        .animate(_controller);
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  void _onDoubleTap(gd.DoubleDetails details) {
        print("_onDoubleTap");

    _normalizedOffset = (details.pointerEvent.position - _offset) / _scale;
    if (!widget.doubleTapStillScale && _scale != 1.0) {
      setState(() {
        _scale = 1.0;
        _offset = Offset.zero;
      });
      return;
    }
    setState(() {
      if (widget.doubleTapStillScale) {
        _scale *= (1 + 0.2);
      } else {
        _scale *= (2);
      }
      // Ensure that image location under the focal point stays in the same place despite scaling.
      // _offset = doubleDownPositon;
      _offset = _clampOffset(
          details.pointerEvent.position - _normalizedOffset * _scale);
    });

    ScaleChangedModel model =
        new ScaleChangedModel(scale: _scale, offset: _offset);
    if (widget.scaleChanged != null) widget.scaleChanged(model);
  }

  @override
  /* 原先的
  Widget build(BuildContext context) {
    return new gd.GestureDetector(
      onPanStart: widget.editMode?null:(DragStartDetails start){
        print("pan start");
      },
      onPanUpdate: widget.editMode?null:(DragUpdateDetails start){
        print("pan onPanUpdate");
      },
      onPanEnd: widget.editMode?null:(DragEndDetails start){
        print("pan onPanEnd");
      },
      // onPanDown: _onPanDown,
      onDoubleTap: _onDoubleTap,
      onScaleStart: !widget.editMode?null:_handleOnScaleStart,
      onScaleUpdate: !widget.editMode?null:_handleOnScaleUpdate,
      onScaleEnd: !widget.editMode?null:_handleOnScaleEnd,
      child: Container(
        margin: widget.margin,
        constraints: const BoxConstraints(
          minWidth: double.maxFinite,
          minHeight: double.infinity,
        ),
        child: new Transform(
            transform: new Matrix4.identity()
              ..translate(_offset.dx, _offset.dy)
              ..scale(_scale, _scale, 1.0),
            child: widget.child),
      ),
    );
  }
}
*/

  Widget build(BuildContext context) {
    Widget child = CustomPaint(
      willChange: true,
      painter: _PainterPainter(widget.painterController._pathHistory,
          repaint: widget.painterController),
    );
    child = ClipRect(child: child);
    if (widget.painterController.backgroundImage == null) {
      child = RepaintBoundary(
        key: _globalKey,
        child: gd.GestureDetector(
          child: child,
          onPanStart: widget.editMode?null:_onPanStart,
          onPanUpdate: widget.editMode?null:_onPanUpdate,
          onPanEnd: widget.editMode?null:_onPanEnd,
                onScaleStart: !widget.editMode?null:_handleOnScaleStart,
      onScaleUpdate: !widget.editMode?null:_handleOnScaleUpdate,
      onScaleEnd: !widget.editMode?null:_handleOnScaleEnd,
        ),
      );
    } else {
      child = RepaintBoundary(
        key: _globalKey,
        child: Stack(
          alignment: FractionalOffset.center,
          fit: StackFit.expand,
          children: <Widget>[
            widget.painterController.backgroundImage,
            gd.GestureDetector(
              child: child,
              onPanStart: widget.editMode?null:_onPanStart,
              onPanUpdate: widget.editMode?null:_onPanUpdate,
              onPanEnd: widget.editMode?null:_onPanEnd,
                    onScaleStart: !widget.editMode?null:_handleOnScaleStart,
      onScaleUpdate: !widget.editMode?null:_handleOnScaleUpdate,
      onScaleEnd: !widget.editMode?null:_handleOnScaleEnd,
            )
          ],
        ),
      );
    }
    // return Container(
    //   child: child,
    //   width: double.infinity,
    //   height: double.infinity,
    // );
    return Container(
        margin: widget.margin,
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: double.infinity,
        ),
        child: new Transform(
            transform: new Matrix4.identity()
              ..translate(_offset.dx, _offset.dy)
              ..scale(_scale, _scale, 1.0),
            child: child),
      );
    
  }


  void _onPanStart(DragStartDetails start) {
    print("_onPanStart");
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController._pathHistory.add(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
        print("_onPanUpdate");

    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController._pathHistory.updateCurrent(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
        print("_onPanEnd");

    widget.painterController._pathHistory.endCurrent();
    widget.painterController._notifyListeners();
  }

}



// ---------------->从这里开始是painter2的代码

class _PainterPainter extends CustomPainter {
  final _PathHistory _path;

  _PainterPainter(this._path, {Listenable repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_PainterPainter oldDelegate) => true;
}

class _PathHistory {
  List<MapEntry<Path, Paint>> _paths;
  List<MapEntry<Path, Paint>> _undone;
  Paint currentPaint;
  Paint _backgroundPaint;
  bool _inDrag;
  double _startX; //start X with a tap
  double _startY; //start Y with a tap
  bool _startFlag = false;
  bool _erase = false;
  double _eraseArea = 1.0;
  bool _pathFound = false;

  _PathHistory() {
    _paths = List<MapEntry<Path, Paint>>();
    _undone = List<MapEntry<Path, Paint>>();
    _inDrag = false;
    _backgroundPaint = Paint();
  }

  bool canUndo() => _paths.length > 0;

  bool get erase => _erase;
  set erase(bool e) {
    _erase = e;
  }

  set eraseArea(double r) {
    _eraseArea = r;
  }

  void undo() {
    if (!_inDrag && canUndo()) {
      _undone.add(_paths.removeLast());
    }
  }

  bool canRedo() => _undone.length > 0;

  void redo() {
    if (!_inDrag && canRedo()) {
      _paths.add(_undone.removeLast());
    }
  }

  void clear() {
    if (!_inDrag) {
      _paths.clear();
      _undone.clear();
    }
  }

  set backgroundColor(color) => _backgroundPaint.color = color;

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _startX = startPoint.dx;
      _startY = startPoint.dy;
      _startFlag = true;
      _paths.add(MapEntry<Path, Paint>(path, currentPaint));
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      _pathFound = false;
      if (!_erase) {
        Path path = _paths.last.key;
        path.lineTo(nextPoint.dx, nextPoint.dy);
        _startFlag = false;
      } else {
        for (int i=0; i<_paths.length; i++) {
          _pathFound = false;
          for (double x = nextPoint.dx - _eraseArea; x <= nextPoint.dx + _eraseArea; x++) {
            for (double y = nextPoint.dy - _eraseArea; y <= nextPoint.dy + _eraseArea; y++) {
              if (_paths[i].key.contains(new Offset(x, y)))
              {
                _undone.add(_paths.removeAt(i));
                i--;
                _pathFound = true;
                break;
              }
            }
            if (_pathFound) {
              break;
            }
          }
        }
      }
    }
  }

  void endCurrent() {
    Path path = _paths.last.key;
    if ((_startFlag) && (!_erase)) { //if it was just a tap, draw a point and reset a flag
      path.addOval(Rect.fromCircle(center: new Offset(_startX, _startY), radius: 1.0));
      _startFlag = false;
    }
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    for (MapEntry<Path, Paint> path in _paths) {
      canvas.drawPath(path.key, path.value);
    }
  }
}

class PainterController extends ChangeNotifier {
  Color _drawColor = Color.fromARGB(255, 0, 0, 0);
  Color _backgroundColor = Color.fromARGB(255, 255, 255, 255);
  mat.Image _bgimage;

  double _thickness = 1.0;
  double _erasethickness = 1.0;
  _PathHistory _pathHistory;
  GlobalKey _globalKey;

  PainterController() {
    _pathHistory = _PathHistory();
  }

  Color get drawColor => _drawColor;
  set drawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  mat.Image get backgroundImage => _bgimage;
  set backgroundImage(mat.Image image) {
    _bgimage = image;
    _updatePaint();
  }

  double get thickness => _thickness;
  set thickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  double get erasethickness => _erasethickness;
  set erasethickness(double t) {
    _erasethickness = t;
    _pathHistory._eraseArea = t;
    _updatePaint();
  }

  bool get eraser => _pathHistory.erase; //setter / getter for eraser
  set eraser(bool e) {
    _pathHistory.erase = e;
    _pathHistory._eraseArea =  _erasethickness;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = Paint();
    paint.color = drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    _pathHistory.currentPaint = paint;
    if (_bgimage != null) {
      _pathHistory.backgroundColor = Color(0x00000000);
    } else {
      _pathHistory.backgroundColor = _backgroundColor;
    }
    notifyListeners();
  }

  void undo() {
    _pathHistory.undo();
    notifyListeners();
  }

  void redo() {
    _pathHistory.redo();
    notifyListeners();
  }

  bool get canUndo => _pathHistory.canUndo();
  bool get canRedo => _pathHistory.canRedo();

  void _notifyListeners() {
    notifyListeners();
  }

  void clear() {
    _pathHistory.clear();
    notifyListeners();
  }

  Future<Uint8List> exportAsPNGBytes() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}



