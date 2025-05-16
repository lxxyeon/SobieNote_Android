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
    final size = MediaQuery.of(context).size;
    final aspectRatio = 9 / 20;

    double targetWidth = size.width;
    double targetHeight = size.width / aspectRatio;

    if (targetHeight > size.height) {
      targetHeight = size.height;
      targetWidth = size.height * aspectRatio;
    }

    final horizontalPadding = (size.width - targetWidth) / 2;
    final verticalPadding = (size.height - targetHeight) / 2;

    return Scaffold(
      backgroundColor: DARK_TEAL,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: SizedBox(
          width: targetWidth,
          height: targetHeight,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/new_onboarding.jpeg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 32),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(userProvider.notifier).login(
                          request: SocialLoginRequest(
                            email: '',
                            name: '',
                            type: SocialType.KAKAO,
                          ),
                        );
                      },
                      child: Image.asset('assets/images/kakao_login.png'),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        ref.read(userProvider.notifier).login(
                          request: SocialLoginRequest(
                            email: '',
                            name: '',
                            type: SocialType.GOOGLE,
                          ),
                        );
                      },
                      child: Image.asset('assets/images/google_login.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
