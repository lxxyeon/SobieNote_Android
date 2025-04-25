// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalResponse _$GoalResponseFromJson(Map<String, dynamic> json) => GoalResponse(
  goalId: (json['goalId'] as num).toInt(),
  memberId: (json['memberId'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
);

Map<String, dynamic> _$GoalResponseToJson(GoalResponse instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'memberId': instance.memberId,
      'year': instance.year,
      'month': instance.month,
    };
