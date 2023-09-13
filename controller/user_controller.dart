import '../model/user.dart';

class UserController {
  UserController._();
  static UserController? _instance;
  static UserController get instance {
    return _instance ??= UserController._();
  }

  final List<User> userList = [];

  User? findUser(int index) {
    return userList.where((element) => element.index == index).first;
  }

  void updateUser(User user) {
    final index = userList.indexWhere((element) => element.index == user.index);
    if (index == -1) {
      userList.add(user);
    } else {
      userList[index] = user;
    }
  }

  List<User> joinedUserList(int roomIndex) {
    return userList.where((element) => element.roomIndex == roomIndex).toList();
  }
}
