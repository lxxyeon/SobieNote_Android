import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';

class SplashScreen extends StatefulWidget {
  static String get routeName => 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (_) => const OnboardingScreen()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DARK_TEAL,
      body: Image.asset('assets/images/new_splash.jpeg'),
    );
  }
}
