import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:stream_channel/stream_channel.dart';

import '../controller/socket_controller.dart';

enum SocketMessageType {
  connect,
  lobby,
  room,
}

class WebSocketHandler {
  final controller = SocketController.instance;

  Handler get handler {
    final handler = webSocketHandler((StreamChannel channel) {
      channel.stream.listen((event) {
        listener(
          event: event,
          channel: channel,
        );
      });
    });
    return handler;
  }

  void listener({
    required dynamic event,
    required StreamChannel channel,
  }) {
    final message = Map<String, dynamic>.from(jsonDecode(event));
    final type = message["type"];
    final index = message["index"];
    if (type == null || index == null) {
      return;
    }
    controller.connect(index, channel);
  }
}
