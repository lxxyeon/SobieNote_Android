// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      keyword: json['keyword'] as String,
      value_cnt: (json['value_cnt'] as num).toInt(),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'value_cnt': instance.value_cnt,
    };
