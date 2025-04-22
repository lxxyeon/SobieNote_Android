import 'package:flutter/material.dart';
import 'package:sobienote_flutter/view/home_screen.dart';
import 'package:sobienote_flutter/view/report_screen.dart';
import 'package:sobienote_flutter/view/upload_screen.dart';

import '../component/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            controller.index = index;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: '추가',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: '보고서',
          ),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [HomeScreen(), UploadScreen(), ReportScreen()],
      ),
    );
  }
}
