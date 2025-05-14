import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/goal/request/goal_request.dart';

import '../common/const/data.dart';
import '../common/provider/secure_storage.dart';
import 'goal_repository.dart';

final goalProvider = FutureProvider.family<String, (int year, int month)>((ref, args) async {
  final repo = ref.watch(goalRepositoryProvider);
  final memberId = await ref
      .watch(secureStorageProvider)
      .read(key: MEMBER_ID_KEY);
  final response = await repo.getGoal(int.parse(memberId!), args.$1, args.$2);
  return response.data;
});

final setGoalProvider = FutureProvider.autoDispose.family<void, (int year, int month, String goalText)>((
  ref,
  args,
) async {
  final repo = ref.watch(goalRepositoryProvider);
  final memberId = await ref
      .watch(secureStorageProvider)
      .read(key: MEMBER_ID_KEY);
  await repo.setGoal(int.parse(memberId!), args.$1, args.$2, GoalRequest(mission: args.$3));
});
