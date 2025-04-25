// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardImage _$BoardImageFromJson(Map<String, dynamic> json) => BoardImage(
  boardId: (json['boardId'] as num).toInt(),
  imagePath: json['imagePath'] as String,
);

Map<String, dynamic> _$BoardImageToJson(BoardImage instance) =>
    <String, dynamic>{
      'boardId': instance.boardId,
      'imagePath': instance.imagePath,
    };
