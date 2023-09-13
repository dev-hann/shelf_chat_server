import 'package:equatable/equatable.dart';

import 'photo_chat.dart';
import 'text_chat.dart';

enum ChatType {
  text,
  photo,
}

abstract class Chat extends Equatable {
  Chat({
    int? index,
    required this.senderIndex,
    required this.data,
    required this.chatType,
  }) : index = index ?? DateTime.now().microsecondsSinceEpoch;
  final int index;
  final int senderIndex;
  final ChatType chatType;
  final dynamic data;

  @override
  List<Object?> get props => [
        index,
        data,
        chatType,
      ];

  Map<String, dynamic> toMap();

  static Chat fromMap(dynamic data) {
    final map = Map<String, dynamic>.from(data);
    final typeIndex = map["typeIndex"];
    final type = ChatType.values[typeIndex];
    switch (type) {
      case ChatType.text:
        return TextChat.fromMap(map);
      case ChatType.photo:
        return PhotoChat.fromMap(map);
    }
  }
}
