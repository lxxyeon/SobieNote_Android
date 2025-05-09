import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/goal/request/goal_request.dart';

import '../common/const/data.dart';
import '../common/provider/secure_storage.dart';
import 'goal_repository.dart';

final goalProvider = FutureProvider<String>((ref) async {
  final repo = ref.watch(goalRepositoryProvider);
  final memberId = await ref
      .watch(secureStorageProvider)
      .read(key: MEMBER_ID_KEY);
  final response = await repo.getGoal(int.parse(memberId!));
  return response.data;
});

final setGoalProvider = FutureProvider.autoDispose.family<void, String>((
  ref,
  goalText,
) async {
  final repo = ref.watch(goalRepositoryProvider);
  final memberId = await ref
      .watch(secureStorageProvider)
      .read(key: MEMBER_ID_KEY);
  await repo.setGoal(int.parse(memberId!), GoalRequest(mission: goalText));
});
