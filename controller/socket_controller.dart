import 'package:stream_channel/stream_channel.dart';

import '../handler/web_socket_handler.dart';

class SocketController {
  SocketController._();

  static SocketController? _instance;

  static SocketController get instance {
    return _instance ??= SocketController._();
  }

  final Map<int, StreamChannel> _channelMap = {};

  void connect(int index, StreamChannel channel) {
    if (_channelMap.containsKey(index)) {
      return;
    }
    _channelMap[index] = channel;
  }

  void sendAll(
    SocketMessageType messageType, {
    List<int>? indexList,
  }) {
    final list = indexList ?? _channelMap.keys;
    for (final index in list) {
      send(
        index: index,
        messageType: messageType,
      );
    }
  }

  void send({
    required int index,
    required SocketMessageType messageType,
  }) {
    final channel = _channelMap[index];
    if (channel == null) {
      return;
    }
    channel.sink.add(messageType.index.toString());
  }
}
