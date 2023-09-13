import '../model/chat/chat.dart';

class ChatController {
  ChatController._();

  static ChatController? _instance;

  static ChatController get instance {
    return _instance ??= ChatController._();
  }

  final Map<int, List<Chat>> _chatMap = {};

  List<Chat> loadChatList(int roomIndex) {
    return _chatMap[roomIndex] ?? [];
  }

  void updateChat(int roomIndex, Chat chat) {
    final list = _chatMap[roomIndex] ?? [];
    list.add(chat);
    _chatMap[roomIndex] = list;
  }
}
