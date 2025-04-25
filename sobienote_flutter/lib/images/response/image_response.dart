import 'package:json_annotation/json_annotation.dart';
import '../model/board_image.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
  final String result;
  final String msg;
  final List<BoardImage> data;

  ImageResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
