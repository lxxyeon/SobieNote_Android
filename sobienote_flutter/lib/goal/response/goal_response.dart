import 'package:json_annotation/json_annotation.dart';

part 'goal_response.g.dart';

@JsonSerializable()
class GoalResponse {
  final int goalId;
  final int memberId;
  final int year;
  final int month;

  GoalResponse({
    required this.goalId,
    required this.memberId,
    required this.year,
    required this.month,
  });

  factory GoalResponse.fromJson(Map<String, dynamic> json) => _$GoalResponseFromJson(json);
}
