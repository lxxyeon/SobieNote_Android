// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardRequest _$BoardRequestFromJson(Map<String, dynamic> json) => BoardRequest(
  contents: json['contents'] as String,
  categories: json['categories'] as String,
  emotions: json['emotions'] as String,
  factors: json['factors'] as String,
  satisfactions: (json['satisfactions'] as num).toInt(),
);

Map<String, dynamic> _$BoardRequestToJson(BoardRequest instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'categories': instance.categories,
      'emotions': instance.emotions,
      'factors': instance.factors,
      'satisfactions': instance.satisfactions,
    };
