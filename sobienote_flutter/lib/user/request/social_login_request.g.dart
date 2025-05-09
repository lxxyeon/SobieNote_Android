// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLoginRequest _$SocialLoginRequestFromJson(Map<String, dynamic> json) =>
    SocialLoginRequest(
      email: json['email'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$SocialTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$SocialLoginRequestToJson(SocialLoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'type': _$SocialTypeEnumMap[instance.type]!,
    };

const _$SocialTypeEnumMap = {
  SocialType.KAKAO: 'KAKAO',
  SocialType.APPLE: 'APPLE',
  SocialType.GOOGLE: 'GOOGLE',
};
