import 'package:flutter/material.dart';
import './touchable_container.dart';

@immutable
class DragScaleContainer extends StatefulWidget {
  Widget child;

  /// 双击内容是否一致放大，默认是true，也就是一致放大
  /// 如果为false，第一次双击放大两倍，再次双击恢复原本大小
  bool doubleTapStillScale;

  bool editMode;
  DragScaleContainer({Widget child, bool doubleTapStillScale = true,this.editMode = true})
      : this.child = child,
        this.doubleTapStillScale = doubleTapStillScale;
  @override
  State<StatefulWidget> createState() {
    return _DragScaleContainerState();
  }
}

class _DragScaleContainerState extends State<DragScaleContainer> {
  PainterController _controller;

    PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.green;
    controller.backgroundImage = Image.network(
        'https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a9e671b9a551f3dedcb2bf64a4eff0ec/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg');
    return controller;
  }


  @override
  void initState() {
    super.initState();
    _controller = newController();
  }

  @override
  Widget build(BuildContext context) {
    // return ClipRect(
    //   child: TouchableContainer(
    //     editMode:widget.editMode,
    //       child: widget.child, doubleTapStillScale: widget.doubleTapStillScale),
    // );
    return Column(
      children: <Widget>[
        Container(
          width: 400,
          height: 400,
          child:ClipRect(
      child: TouchableContainer(
        _controller,
        editMode:widget.editMode,
          child: widget.child, doubleTapStillScale: widget.doubleTapStillScale),
    ),
        ),
        
    GestureDetector(
      child:Container(width: 400, height:100,color: Colors.red),
      onTap:(){
        setState(() {
          widget.editMode = !widget.editMode;
        });
        print("${widget.editMode?"编辑模式":"缩放模式"}");
      }
    )
      ],
    );
  }
}
