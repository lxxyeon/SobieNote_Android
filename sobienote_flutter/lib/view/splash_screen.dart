import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DARK_TEAL,
      body: Image.asset('assets/images/new_splash.jpeg'),
    );
  }
}
