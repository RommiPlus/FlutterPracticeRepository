import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: ScanWidget()
  )
);

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ScanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScanState();
  }
}

class ScanState extends State<ScanWidget> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1, milliseconds: 500));
    animation = Tween<double>(begin: 10, end: 300).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      } else if(status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('扫描动画效果')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: animation.value),
          child: FlutterLogo(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
