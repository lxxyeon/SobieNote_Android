import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'board_request.g.dart';

@JsonSerializable()
class BoardRequest {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? file;
  final String contents;
  final String categories;
  final String emotions;
  final String factors;
  final int satisfactions;

  BoardRequest({
    this.file,
    required this.contents,
    required this.categories,
    required this.emotions,
    required this.factors,
    required this.satisfactions,
  });

  factory BoardRequest.fromJson(Map<String, dynamic> json) =>
      _$BoardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BoardRequestToJson(this);
}