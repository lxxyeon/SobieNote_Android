// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardResponse _$BoardResponseFromJson(Map<String, dynamic> json) =>
    BoardResponse(
      contents: json['contents'] as String,
      categories: json['categories'] as String,
      factors: json['factors'] as String,
      emotions: json['emotions'] as String,
      satisfactions: (json['satisfactions'] as num).toInt(),
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$BoardResponseToJson(BoardResponse instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'categories': instance.categories,
      'factors': instance.factors,
      'emotions': instance.emotions,
      'satisfactions': instance.satisfactions,
      'createdDate': instance.createdDate,
    };
