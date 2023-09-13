import 'package:equatable/equatable.dart';

class Room extends Equatable {
  Room({
    required this.name,
  }) : index = DateTime.now().microsecondsSinceEpoch;
  final int index;
  final String name;

  @override
  List<Object?> get props => [
        index,
        name,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'name': name,
    };
  }
}
