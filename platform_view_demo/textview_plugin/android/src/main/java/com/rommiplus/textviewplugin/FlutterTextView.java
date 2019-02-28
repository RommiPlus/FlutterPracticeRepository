package com.rommiplus.textviewplugin;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class FlutterTextView implements PlatformView, MethodCallHandler  {
  private final TextView textView;
  private final MethodChannel methodChannel;

  FlutterTextView(Context context, BinaryMessenger messenger, int id) {
    textView = new TextView(context);
    textView.setLayoutParams(new ViewGroup.LayoutParams(300, 300));
    textView.setBackgroundColor(Color.BLUE);
    methodChannel = new MethodChannel(messenger, "textview_" + id);
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public View getView() {
    return textView;
  }

  @Override
  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
    switch (methodCall.method) {
      case "setText":
        setText(methodCall, result);
        break;
      default:
        result.notImplemented();
    }

  }

  private void setText(MethodCall methodCall, Result result) {
    String text = (String) methodCall.arguments;
    textView.setText(text);
    result.success(null);
  }

  @Override
  public void dispose() {}
}
