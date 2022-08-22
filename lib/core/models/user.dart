import 'package:freezed_annotation/freezed_annotation.dart'
    show DeepCollectionEquality, JsonKey, freezed;

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    int? id,
    required String name,
    required String email,
    required String gender,
    required String status,
  }) = _User;

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return <String, dynamic>{
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'gender': user.gender,
      'status': user.status,
    };
  }
}
