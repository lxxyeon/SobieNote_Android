
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sobienote_flutter/user/user_provider.dart';
import 'package:sobienote_flutter/view/onboarding_screen.dart';

import '../view/root_tab.dart';
import '../view/splash_screen.dart';
import 'model/user_model.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userProvider, (prev, next) {
      if (prev != next) {
        notifyListeners();
      }
    });
  }

  List<RouteBase> get routes => [
    GoRoute(path: '/', name: RootTab.routeName, builder: (context, state) => RootTab()),
    GoRoute(path: '/splash', name: SplashScreen.routeName, builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', name: OnboardingScreen.routeName, builder: (context, state) => OnboardingScreen()),
  ];

  void logout() {
    ref.read(userProvider.notifier).logout();
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.watch(userProvider);
    final loggingIn = state.matchedLocation == '/login';

    if (user == null) {
      return loggingIn ? null : '/login';
    }

    if (user is UserModel) {
      return loggingIn || state.matchedLocation == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !loggingIn ? '/login' : null;
    }

    return null;
  }
}