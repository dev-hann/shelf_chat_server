import 'chat.dart';

class PhotoChat extends Chat {
  PhotoChat({
    required super.senderIndex,
    required String path,
  }) : super(
          chatType: ChatType.photo,
          data: path,
        );

  String get path => data;

  @override
  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "senderIndex": senderIndex,
      "path": path,
    };
  }

  factory PhotoChat.fromMap(dynamic data) {
    final map = Map<String, dynamic>.from(data);
    return PhotoChat(
      senderIndex: map["senderIndex"],
      path: map["path"],
    );
  }
}
