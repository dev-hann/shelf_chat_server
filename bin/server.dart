import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handler/lobby_hnadler.dart';
import '../handler/room_handler.dart';
import '../handler/web_socket_handler.dart';

void main(List<String> args) async {
  final router = Router()
    ..mount("/api/room", RoomHandler().router)
    ..mount("/api/lobby", LobbyHandler().router);
  final ip = InternetAddress.anyIPv4;
  final pipeLine = Pipeline().addMiddleware(logRequests());
  final handler = pipeLine.addHandler(router);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  withHotreload(() async {
    print('Server listening on port http://localhost:${server.port}');
    return server;
  });

  var socket = WebSocketHandler().handler;
  serve(socket, "localhost", port);
}
