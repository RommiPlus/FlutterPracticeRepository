import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TextviewPlugin {
  static const MethodChannel _channel = const MethodChannel('textview_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

typedef TextViewCreatedCallback = void Function(TextViewController controller);
//typedef void TextViewCreatedCallback(TextViewController controller);

class TextView extends StatefulWidget {
  final TextViewCreatedCallback onTextViewCreated;

  const TextView({Key key, this.onTextViewCreated}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextViewState();
  }
}

class TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
          viewType: 'textview', onPlatformViewCreated: onPlatformViewCreated);
    }
    return null;
  }

  void onPlatformViewCreated(int id) {
    if (widget.onTextViewCreated == null) return;
    widget.onTextViewCreated(TextViewController.init(id));
  }
}

class TextViewController {
  final MethodChannel _channel;

  TextViewController.init(int id)
      : _channel = new MethodChannel('textview_$id');

  Future<void> setText(String text) async {
    return _channel.invokeMethod('setText', text);
  }
}
