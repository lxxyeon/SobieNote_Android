import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/view/setting_screen.dart';

import '../common/const/text_style.dart';
import '../component/top_sheet_selector.dart';
import '../images/image_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isTopSheetVisible = false;
  bool isSelectingYear = false;

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  void _toggleTopSheet() {
    setState(() {
      isTopSheetVisible = !isTopSheetVisible;
    });
  }

  void _toggleMode() {
    setState(() {
      isSelectingYear = !isSelectingYear;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight =
        MediaQuery.of(context).padding.top + kToolbarHeight;
    final images = ref.watch(imagesProvider((selectedYear, selectedMonth, 13)));

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              centerTitle: true,
              expandedHeight: kToolbarHeight + 130,
              title: GestureDetector(
                onTap: _toggleTopSheet,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🗓 $selectedMonth 월 소비기록', style: kTitleTextStyle),
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
                          Text(
                            '이번 달 소비목표',
                            style: TextStyle(fontSize: 16, color: FONT_GRAY),
                          ),
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
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (images.isLoading)
              SliverFillRemaining(child: CircularProgressIndicator())
            else if (images.hasError || images.value == null || images.value!.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Image.asset('assets/images/nullImg_G.png'),
              )
            else if (images.value!.isNotEmpty)
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Image.network(images.value![index].imagePath);
                }, childCount: images.value!.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
              ),
          ],
        ),
        if (isTopSheetVisible)
          Positioned.fill(
            top: appBarHeight,
            child: GestureDetector(
              onTap: _toggleTopSheet,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
        TopSheetSelector(
          isVisible: isTopSheetVisible,
          topOffset: appBarHeight,
          selectedMonth: selectedMonth,
          selectedYear: selectedYear,
          tabIndex: 0,
          isSelectingYear: isSelectingYear,
          onToggleMode: _toggleMode,
          onMonthSelected: (val) {
            setState(() {
              selectedMonth = val;
            });
          },
          onYearSelected: (val) {
            setState(() {
              selectedYear = val;
            });
          },
        ),
      ],
    );
  }
}
