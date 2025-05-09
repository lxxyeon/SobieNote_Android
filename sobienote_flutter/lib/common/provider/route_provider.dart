import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../user/auth_provider.dart';

final routerProvider = Provider((ref) {
  final provider = ref.watch(authProvider);
  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});