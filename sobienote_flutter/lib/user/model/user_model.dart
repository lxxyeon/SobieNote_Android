
import 'package:json_annotation/json_annotation.dart';
import 'package:sobienote_flutter/user/request/social_login_request.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({required this.message});
}

class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final String email;
  final SocialType type;
  final String? nickName;

  UserModel(
      {required this.email,
        required this.type,
        required this.nickName});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
