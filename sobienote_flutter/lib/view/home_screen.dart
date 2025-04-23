import 'package:flutter/material.dart';
import 'package:sobienote_flutter/view/setting_screen.dart';

import '../common/const/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          centerTitle: true,
          title: GestureDetector(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🗓 소비기록', style: kTitleTextStyle),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              icon: Icon(Icons.more_horiz),
            ),
          ],
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ColoredBox(color: Colors.yellow,);
          }, childCount: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        ),
      ],
    );
  }
}
