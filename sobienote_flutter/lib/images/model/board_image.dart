import 'package:json_annotation/json_annotation.dart';

part 'board_image.g.dart';

@JsonSerializable()
class BoardImage {
  final int boardId;
  final String imagePath;

  BoardImage({required this.boardId, required this.imagePath});

  factory BoardImage.fromJson(Map<String, dynamic> json) => _$BoardImageFromJson(json);
}
