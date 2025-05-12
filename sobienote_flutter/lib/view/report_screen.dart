import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/common/const/text_style.dart';
import 'package:sobienote_flutter/component/report/report_category.dart';
import 'package:sobienote_flutter/component/report/report_gauge.dart';
import 'package:sobienote_flutter/component/report/report_rank.dart';
import 'package:sobienote_flutter/report/report_provider.dart';

import '../common/response/base_response.dart';
import '../common/util/save_share.dart';
import '../component/report/report_pie_chart.dart';
import '../component/top_sheet_selector.dart';
import '../report/response/report_response.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen>
    with TickerProviderStateMixin {
  bool isTopSheetVisible = false;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int tabIdx = 0;
  late TabController tabController;
  final GlobalKey captureKey = GlobalKey();

  late Future<BaseResponse<List<ReportResponse>>> _categoriesFuture;
  late Future<BaseResponse<List<ReportResponse>>> _factorsFuture;
  late Future<BaseResponse<List<ReportResponse>>> _emotionsFuture;
  late Future<BaseResponse<double>> _avgSatisfactionFuture;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        tabIdx = tabController.index;
        _loadData();
      });
    });    _loadData();
  }

  void _loadData() {
    final report = ref.read(reportNotifierProvider);
    final int? month = (tabIdx == 0) ? selectedMonth : null;

    _categoriesFuture = report.getCategories(selectedYear, month);
    _factorsFuture = report.getFactors(selectedYear, month);
    _emotionsFuture = report.getEmotions(selectedYear, month);
    _avgSatisfactionFuture = report.getAvgSatisfaction(selectedYear, month);
  }

  void _toggleTopSheet() {
    setState(() {
      isTopSheetVisible = !isTopSheetVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight =
        MediaQuery.of(context).padding.top + kToolbarHeight + kTextTabBarHeight;
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
        child: Column(
          children: [
            RepaintBoundary(
              key: captureKey,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ReportCategory(categories: _categoriesFuture),
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 32),
                    ReportRank(factors: _factorsFuture),
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 32),
                    ReportPieChart(emotions: _emotionsFuture),
                    const Divider(),
                    const SizedBox(height: 32),
                    ReportGauge(percentage: _avgSatisfactionFuture),
                    const SizedBox(height: 66),
                  ],
                ),
              ),
            ),
            _buildActionButtons(),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      height: 50,
      width: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: KEYPAD_GRAY,
          child: Center(
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    label: const Text('저장하기'),
                    icon: const Icon(Icons.save_alt),
                    onPressed: _handleSave,
                    style: TextButton.styleFrom(foregroundColor: FONT_GRAY),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: FONT_GRAY,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  TextButton.icon(
                    label: const Text('공유하기'),
                    icon: const Icon(Icons.ios_share_rounded),
                    onPressed: _handleShare,
                    style: TextButton.styleFrom(foregroundColor: FONT_GRAY),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    await MediaStore.ensureInitialized();
    MediaStore.appFolder = 'Sobienote';
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("저장 권한이 필요해요")));
      return;
    }
    try {
      await WidgetsBinding.instance.endOfFrame;
      final boundary =
          captureKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      await saveImageToGallery(pngBytes);
      showCupertinoDialog(context: context, builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('보고서 저장 완료'),
          content: const Text('앨범에 보고서를 저장했습니다'),
          actions: [
            CupertinoDialogAction(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      });
    } catch (e) {
      print("저장 실패: $e");
    }
  }

  Future<void> _handleShare() async {
    try {
      await WidgetsBinding.instance.endOfFrame;

      final boundary =
          captureKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      await shareImage(pngBytes);
    } catch (e) {
      print("공유 실패: $e");
    }
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
          ),
        ],
      ),
    );
  }

  Widget _buildDarkOverlay(double appBarHeight) {
    return Positioned.fill(
      top: appBarHeight,
      child: Container(color: const Color.fromRGBO(0, 0, 0, 0.3)),
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
      onMonthSelected: (val) => setState(() {
        selectedMonth = val;
        _loadData();
      }),
      onYearSelected: (val) => setState(() {
        selectedYear = val;
        _loadData();
      }),
    );
  }
}
