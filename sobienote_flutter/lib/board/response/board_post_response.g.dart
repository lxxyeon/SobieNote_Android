// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardPostResponse _$BoardPostResponseFromJson(Map<String, dynamic> json) =>
    BoardPostResponse(
      boardId: (json['boardId'] as num).toInt(),
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$BoardPostResponseToJson(BoardPostResponse instance) =>
    <String, dynamic>{
      'boardId': instance.boardId,
      'imagePath': instance.imagePath,
    };
