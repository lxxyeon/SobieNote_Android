import 'package:json_annotation/json_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  final String keyword;
  final int value_cnt;

  ReportResponse({required this.keyword, required this.value_cnt});

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);

}
