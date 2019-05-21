package com.omron.jpush_demo;

import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;

import java.util.IllegalFormatCodePointException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    MethodChannel methodChannel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        methodChannel = new MethodChannel(getFlutterView(), "pageControl");
        methodChannel.setMethodCallHandler((methodCall, result) -> {
            if (methodCall.method.equals("toBackGround")) {
                moveTaskToBack(true);
            }
        });
    }

}
