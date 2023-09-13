import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controller/room_controller.dart';
import '../controller/user_controller.dart';
import '../model/room.dart';
import '../model/user.dart';

class LobbyHandler {
  final roomController = RoomController.instance;
  final userController = UserController.instance;

  Router get router {
    final router = Router();
    router.get(
      "/roomList",
      loadRoomList,
    );
    router.get(
      "/userList",
      loadUserList,
    );
    router.post(
      "/user",
      createUser,
    );
    router.post(
      "/room",
      createRoom,
    );
    router.delete(
      "/room",
      removeRoom,
    );
    router.post(
      "/joinRoom",
      joinRoom,
    );
    router.post(
      "/exitRoom",
      exitRoom,
    );
    return router;
  }

  Future<Response> loadRoomList(Request request) async {
    final roomList = roomController.roomList;
    return Response.ok(
      jsonEncode(
        roomList.map((e) => e.toMap()).toList(),
      ),
    );
  }

  Future<Response> createUser(Request request) async {
    final p = jsonDecode(await request.readAsString());
    final name = p["name"];
    if (name == null) {
      return Response.badRequest();
    }
    userController.userList.add(
      User(name: name),
    );
    return Response.ok("OK");
  }

  Future<Response> createRoom(Request request) async {
    final p = jsonDecode(await request.readAsString());
    final name = p["name"];
    if (name == null) {
      return Response.badRequest();
    }
    roomController.updateRoom(
      Room(
        name: name,
      ),
    );
    return Response.ok("OK");
  }

  Future<Response> removeRoom(Request request) async {
    final p = jsonDecode(await request.readAsString());
    final index = p["index"];
    if (index == null) {
      return Response.badRequest();
    }
    roomController.removeRoom(index);
    return Response.ok("OK");
  }

  Future<Response> joinRoom(Request request) async {
    final p = jsonDecode(await request.readAsString());
    final roomIndex = int.tryParse(p["roomIndex"]);
    final userIndex = int.tryParse(p["userIndex"]);
    if (roomIndex == null || userIndex == null) {
      return Response.badRequest();
    }
    final room = roomController.findRoom(roomIndex);
    if (room == null) {
      return Response.badRequest();
    }
    final user = userController.findUser(userIndex);
    if (user == null) {
      return Response.badRequest();
    }

    userController.updateUser(
      user.copyWith(
        roomIndexOption: Some(roomIndex),
      ),
    );
    return Response.ok("OK");
  }

  Future<Response> exitRoom(Request request) async {
    final p = jsonDecode(await request.readAsString());
    final roomIndex = int.tryParse(p["roomIndex"]);
    final userIndex = int.tryParse(p["userIndex"]);
    if (roomIndex == null || userIndex == null) {
      return Response.badRequest();
    }
    final room = roomController.findRoom(roomIndex);
    if (room == null) {
      return Response.badRequest();
    }
    final user = userController.findUser(userIndex);
    if (user == null) {
      return Response.badRequest();
    }

    userController.updateUser(
      user.copyWith(
        roomIndexOption: None(),
      ),
    );
    return Response.ok("OK");
  }

  Future<Response> loadUserList(Request request) async {
    final userList = userController.userList;
    return Response.ok(
      jsonEncode(
        userList.map((e) => e.toMap()).toList(),
      ),
    );
  }
}
