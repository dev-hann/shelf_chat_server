import 'chat.dart';

class TextChat extends Chat {
  TextChat({
    required super.senderIndex,
    required String text,
  }) : super(
          chatType: ChatType.text,
          data: text,
        );
  String get text => data;

  @override
  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'senderIndex': senderIndex,
      'text': text,
    };
  }

  factory TextChat.fromMap(dynamic data) {
    final map = Map<String, dynamic>.from(data);
    return TextChat(
      senderIndex: map["senderIndex"],
      text: map["text"],
    );
  }
}
