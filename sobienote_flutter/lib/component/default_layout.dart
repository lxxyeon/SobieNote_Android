import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  const DefaultLayout({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const aspectRatio = 9 / 20;

    double targetWidth = size.width;
    double targetHeight = size.width / aspectRatio;

    if (targetHeight > size.height) {
      targetHeight = size.height;
      targetWidth = size.height * aspectRatio;
    }

    final horizontalPadding = (size.width - targetWidth) / 2;
    final verticalPadding = (size.height - targetHeight) / 2;

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: SizedBox(width: targetWidth, height: targetHeight, child: child),
      ),
    );
  }
}
