import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/common/const/text_style.dart';
import 'package:sobienote_flutter/common/response/base_response.dart';
import 'package:sobienote_flutter/report/response/report_response.dart';

class ReportCategory extends StatelessWidget {
  final Future<BaseResponse<List<ReportResponse>>> categories;

  const ReportCategory({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BaseResponse<List<ReportResponse>>>(
      future: categories,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data!.data;
        items.sort((a, b) => b.value_cnt.compareTo(a.value_cnt));
        final half = (items.length / 2).ceil();
        final leftList = items.sublist(0, half);
        final rightList = items.sublist(half);

        return SizedBox(
          height: 350,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이번 달엔 여기에 많이 썼어요', style: kTitleTextStyle),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: _buildColumn(leftList, CrossAxisAlignment.end, TextAlign.right),
                  ),
                  Container(
                    height: 250,
                    width: 1,
                    color: GRAY_06,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  Expanded(
                    child: _buildColumn(rightList, CrossAxisAlignment.start, TextAlign.left),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColumn(
      List<ReportResponse> categories,
      CrossAxisAlignment alignment,
      TextAlign textAlign,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: alignment,
      children: categories.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.keyword,
                textAlign: textAlign,
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(child: Container()),
              Text('${item.value_cnt}', style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
