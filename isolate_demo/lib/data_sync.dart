import 'dart:isolate';

import 'package:meta/meta.dart';

/// 新isolate的发送端口
SendPort newIsolatedSendPort;

/// 新开辟的dart vm虚拟机空间
Isolate newIsolate;

void callerCreateIsolate() async {
  // main isolate的接收端口
  ReceivePort receivePort = ReceivePort();

  // receivePort.sendPort：main isolate的发送端口
  newIsolate = await Isolate.spawn(callbackFunction, receivePort.sendPort);

  // 获取新isolate的发送端口
  newIsolatedSendPort = await receivePort.first;
}

void callbackFunction(SendPort callerSendPort) {
  // 新isolate的接收端口
  ReceivePort newIsolatedReceivePort = ReceivePort();

  // 使用调用端的sendPort发送当前isolate的sendPort
  callerSendPort.send(newIsolatedReceivePort.sendPort);

  newIsolatedReceivePort.listen((dynamic message) {
    CrossIsolatesMessage incomingMessage = message as CrossIsolatesMessage;
    String newMessage = "complemented string ${incomingMessage.message}";
    incomingMessage.sender.send(newMessage);
  });
}

Future<String> sendReceive(String messageToBeSent) async {
  ReceivePort port = ReceivePort();

  newIsolatedSendPort.send(CrossIsolatesMessage<String> (
    sender: port.sendPort,
    message: messageToBeSent,
  ));

  return await port.first;
}

class CrossIsolatesMessage<T> {
  final SendPort sender;
  final T message;

  CrossIsolatesMessage({@required this.sender, this.message});
}

void dispose() {
  newIsolate?.kill(priority: Isolate.immediate);
  newIsolate = null;
}