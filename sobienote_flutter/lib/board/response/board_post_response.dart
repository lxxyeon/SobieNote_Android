import 'package:json_annotation/json_annotation.dart';

part 'board_post_response.g.dart';

@JsonSerializable()
class BoardPostResponse {
  final int boardId;
  final String imagePath;

  BoardPostResponse({required this.boardId, required this.imagePath});

  factory BoardPostResponse.fromJson(Map<String, dynamic> json) => _$BoardPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BoardPostResponseToJson(this);
}
