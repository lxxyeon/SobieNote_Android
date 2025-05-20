import 'package:json_annotation/json_annotation.dart';

part 'social_login_request.g.dart';

enum SocialType {
  KAKAO,
  GOOGLE,
  LOCAL;

  static SocialType getByName(String name) {
    return SocialType.values.firstWhere(
      (e) => e.name.toUpperCase() == name.toUpperCase(),
      orElse: () => SocialType.KAKAO,
    );
  }
}

@JsonSerializable()
class SocialLoginRequest {
  final String email;
  final String name;
  final SocialType type;

  SocialLoginRequest({
    required this.email,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() => _$SocialLoginRequestToJson(this);
}
