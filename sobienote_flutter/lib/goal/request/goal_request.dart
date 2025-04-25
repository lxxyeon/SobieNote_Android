import 'package:json_annotation/json_annotation.dart';

part 'goal_request.g.dart';

@JsonSerializable()
class GoalRequest {
  final String mission;

  GoalRequest({required this.mission});

  factory GoalRequest.fromJson(Map<String, dynamic> json) => _$GoalRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GoalRequestToJson(this);
}