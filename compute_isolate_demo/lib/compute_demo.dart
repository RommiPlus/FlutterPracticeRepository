import 'dart:io';

import 'package:flutter/foundation.dart';

/// 有一个调用compute的函数，还有一个compute使用的回调函数和参数
Future<String> callCompute() async {
  // compute 返回类型不能返回Future类型，这意味着其使用同步函数才能获得执行的结果；异步函数只能执行无法获知执行的结果。
  return await compute(computeLotOfData, 10);
}

String computeLotOfData(int endNum) {
  int total = 0;
  for(int i = 0; i < endNum; i++) {
    sleep(Duration(seconds: 1));
    total += i;
  }
  return '$total';
}

