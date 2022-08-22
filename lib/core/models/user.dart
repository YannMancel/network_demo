import 'package:freezed_annotation/freezed_annotation.dart'
    show DeepCollectionEquality, JsonKey, freezed;

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String name,
    required String email,
  }) = _User;

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
