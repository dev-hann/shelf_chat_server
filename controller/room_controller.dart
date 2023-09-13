import '../model/room.dart';

class RoomController {
  RoomController._();

  static RoomController? _instance;

  static RoomController get instance {
    return _instance ??= RoomController._();
  }

  final List<Room> roomList = [];

  void updateRoom(Room room) {
    final index = roomList.indexWhere((element) => element == room);
    if (index == -1) {
      roomList.add(room);
    } else {
      roomList[index] = room;
    }
  }

  void removeRoom(int roomIndex) {
    final index = roomList.indexWhere((element) => element.index == roomIndex);
    if (index != -1) {
      roomList.removeAt(index);
    }
  }

  Room? findRoom(int index) {
    return roomList.where((element) => element.index == index).first;
  }
}
