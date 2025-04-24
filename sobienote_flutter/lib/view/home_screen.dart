import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
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
          expandedHeight: kToolbarHeight + 130,
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(130),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('이번 달 소비목표', style: TextStyle(fontSize: 16, color: FONT_GRAY)),
                        const SizedBox(height: 9),
                        TextField(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: '목표를 적어주세요!',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            suffixIcon: Icon(
                              Icons.arrow_circle_up_rounded,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: TEAL,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // PreferredSize 높이에 맞추기 위한 여유 공간
                ],
              ),
            ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Image.asset('assets/images/nullImg_G.png'),
        )
        // SliverGrid(
        //   delegate: SliverChildBuilderDelegate((context, index) {
        //     return ColoredBox(color: Colors.yellow);
        //   }, childCount: 16),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //   ),
        // ),
      ],
    );
  }
}
