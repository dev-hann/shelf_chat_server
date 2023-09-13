// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class User extends Equatable {
  User({
    int? index,
    required this.name,
    this.roomIndex,
  }) : index = index ?? DateTime.now().microsecondsSinceEpoch;
  final int index;
  final String name;
  final int? roomIndex;

  @override
  List<Object?> get props => [
        index,
        name,
        roomIndex,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'name': name,
      'roomIndex': roomIndex,
    };
  }

  User copyWith({
    String? name,
    Option<int>? roomIndexOption,
  }) {
    return User(
      index: index,
      name: name ?? this.name,
      roomIndex:
          roomIndexOption == null ? roomIndex : roomIndexOption.toNullable(),
    );
  }
}
