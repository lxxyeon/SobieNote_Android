import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/common/const/text_style.dart';
import 'package:sobienote_flutter/component/report/report_category.dart';
import 'package:sobienote_flutter/component/report/report_gauge.dart';
import 'package:sobienote_flutter/component/report/report_rank.dart';

import '../component/top_sheet_selector.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with TickerProviderStateMixin {
  bool isTopSheetVisible = false;
  int selectedMonth = DateTime
      .now()
      .month;
  int selectedYear = DateTime
      .now()
      .year;
  int tabIdx = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_onTabToggle);
    tabController.addListener(() {
      setState(() {
        tabIdx = tabController.index;
      });
    });
  }

  void _onTabToggle() {
    if (tabController.indexIsChanging) return;
    setState(() {
      if (tabController.index == 0) {
        tabIdx = 0;
        selectedMonth = DateTime
            .now()
            .month;
      } else {
        tabIdx = 0;
        selectedYear = DateTime
            .now()
            .year;
      }
    });
  }

  void _toggleTopSheet() {
    setState(() {
      isTopSheetVisible = !isTopSheetVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight =
        MediaQuery
            .of(context)
            .padding
            .top + kToolbarHeight + kTextTabBarHeight;

    return Stack(
      children: [
        _reportBody(appBarHeight),
        if (isTopSheetVisible) _buildDarkOverlay(appBarHeight),
        if (isTopSheetVisible) _buildDismissArea(appBarHeight),
        _buildTopSheet(appBarHeight),
      ],
    );
  }

  Widget _reportBody(double appBarHeight) {
    return NestedScrollView(
      headerSliverBuilder: (_, __) => [_buildSliverAppBar()],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ReportCategory(),
            const SizedBox(height: 66),
            const Divider(),
            const SizedBox(height: 32),
            ReportRank(),
            const SizedBox(height: 66),
            const Divider(),
            const SizedBox(height: 32),
            ReportGauge(percentage: 0.8),
            const SizedBox(height: 66),
            const Divider(),
            const SizedBox(height: 32),

          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: false,
      backgroundColor: isTopSheetVisible ? Colors.white : Colors.transparent,
      elevation: 0,
      toolbarHeight: kToolbarHeight + kTextTabBarHeight,
      title: Column(
        children: [
          TabBar(
            controller: tabController,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: DARK_TEAL,
            indicatorWeight: 3.0,
            tabs: const [
              Tab(child: Text('월간', style: kTitleTextStyle)),
              Tab(child: Text('연간', style: kTitleTextStyle)),
            ],
          ),
          GestureDetector(
            onTap: _toggleTopSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tabController.index == 0
                        ? '$selectedMonth월'
                        : '$selectedYear년',
                    style: kTitleTextStyle,
                  ),
                  Icon(
                    isTopSheetVisible
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDarkOverlay(double appBarHeight) {
    return Positioned.fill(
      top: appBarHeight,
      child: Container(color: Color.fromRGBO(0, 0, 0, 0.3)),
    );
  }

  Widget _buildDismissArea(double appBarHeight) {
    return Positioned.fill(
      top: appBarHeight,
      child: GestureDetector(
        onTap: _toggleTopSheet,
        behavior: HitTestBehavior.translucent,
        child: Container(),
      ),
    );
  }

  Widget _buildTopSheet(double appBarHeight) {
    return TopSheetSelector(
      isVisible: isTopSheetVisible,
      topOffset: appBarHeight,
      selectedMonth: selectedMonth,
      selectedYear: selectedYear,
      tabIndex: tabIdx,
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
    );
  }
}
