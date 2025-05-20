// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  email: json['email'] as String,
  type: $enumDecode(_$SocialTypeEnumMap, json['type']),
  nickName: json['nickName'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'email': instance.email,
  'type': _$SocialTypeEnumMap[instance.type]!,
  'nickName': instance.nickName,
};

const _$SocialTypeEnumMap = {
  SocialType.KAKAO: 'KAKAO',
  SocialType.GOOGLE: 'GOOGLE',
  SocialType.LOCAL: 'LOCAL',
};
