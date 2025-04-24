import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {},
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
