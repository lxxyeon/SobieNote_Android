import 'package:json_annotation/json_annotation.dart';

part 'board_response.g.dart';

@JsonSerializable()
class BoardResponse {
  final String content;
  final String categories;
  final String factors;
  final String emotions;
  final int satisfactions;
  final String createdDate;

  BoardResponse({
    required this.content,
    required this.categories,
    required this.factors,
    required this.emotions,
    required this.satisfactions,
    required this.createdDate,
  });

  factory BoardResponse.fromJson(Map<String, dynamic> json) => _$BoardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardResponseToJson(this);
}
