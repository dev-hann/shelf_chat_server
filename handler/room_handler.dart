import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controller/chat_controller.dart';
import '../controller/user_controller.dart';
import '../model/chat/chat.dart';

class RoomHandler {
  final chatController = ChatController.instance;
  final userController = UserController.instance;

  Router get router {
    final router = Router();
    router.get("/chatList/<roomIndex>", loadChatList);
    router.post("/chat", updateChat);
    router.get("/userList/<roomIndex>", joinedUserList);
    return router;
  }

  Future<Response> loadChatList(Request request) async {
    final p = request.params;
    final roomIndex = int.tryParse(p["roomIndex"].toString());
    if (roomIndex == null) {
      return Response.badRequest();
    }
    final list = chatController.loadChatList(roomIndex);
    return Response.ok(
      jsonEncode(
        list.map((e) => e.toMap()).toList(),
      ),
    );
  }

  Future<Response> updateChat(Request request) async {
    final p = jsonDecode(await request.readAsString());
    final chatData = Map<String, dynamic>.from(p["chat"]);
    final roomIndex = p["roomIndex"];
    if (roomIndex == null || chatData.isEmpty) {
      return Response.badRequest();
    }
    chatController.updateChat(
      roomIndex,
      Chat.fromMap(chatData),
    );
    return Response.ok("OK");
  }

  Future<Response> joinedUserList(Request request) async {
    final p = request.params;
    final roomIndex = int.tryParse(p["roomIndex"].toString());
    if (roomIndex == null) {
      return Response.badRequest();
    }
    final list = userController.joinedUserList(roomIndex);
    return Response.ok(
      jsonEncode(
        list.map((e) => e.toMap()).toList(),
      ),
    );
  }
}
