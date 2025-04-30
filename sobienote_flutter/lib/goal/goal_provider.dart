import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/goal/request/goal_request.dart';

import 'goal_repository.dart';

final goalProvider = FutureProvider<String>((ref) async {
  final repo = ref.watch(goalRepositoryProvider);
  //TODO: 추후 로그인 구현 후 secure_storage 연동 예정
  const testMemberId = 52;
  final response = await repo.getGoal(testMemberId);
  return response.data;
});

final setGoalProvider = FutureProvider.autoDispose.family<void, String>((ref, goalText) async {
  final repo = ref.watch(goalRepositoryProvider);
  //TODO: 추후 로그인 구현 후 secure_storage 연동 예정
  const testMemberId = 52;
  await repo.setGoal(testMemberId, GoalRequest(mission: goalText));
});