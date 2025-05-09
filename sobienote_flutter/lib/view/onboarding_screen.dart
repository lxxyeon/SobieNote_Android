import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/user/request/social_login_request.dart';

import '../user/user_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  static String get routeName => 'onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: DARK_TEAL,
      body: Column(
        children: [
          Image.asset('assets/images/new_onboarding.jpeg'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    ref.read(userProvider.notifier).login(request: SocialLoginRequest(email: '', name: '', type: SocialType.KAKAO));
                  },
                  child: Image.asset('assets/images/kakao_login.png'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/apple_login.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
