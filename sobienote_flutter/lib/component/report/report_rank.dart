import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/common/response/base_response.dart';
import 'package:sobienote_flutter/report/response/report_response.dart';

import '../../common/const/text_style.dart';

class ReportRank extends StatelessWidget {
  final Future<BaseResponse<List<ReportResponse>>> factors;
  const ReportRank({super.key, required this.factors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('이런 물건에 관심이 많았어요', style: kTitleTextStyle),
        ),
        const SizedBox(height: 30),
        renderRank(),
      ],
    );
  }

  Widget renderRank() {
    return FutureBuilder<BaseResponse<List<ReportResponse>>>(
      future: factors,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data!.data;
        final sorted = List<ReportResponse>.from(items)
          ..sort((a, b) => b.value_cnt.compareTo(a.value_cnt));
        final top5 = sorted.take(5).toList();
        return Column(
          children: top5.map((item) {
            final rank = top5.indexOf(item) + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 25,
                        height: 25,
                        color: DARK_TEAL,
                        child: Center(
                          child: Text(
                            '$rank',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.keyword,
                      style: TextStyle(
                        fontWeight: rank == 1 ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    '${item.value_cnt}',
                    style: TextStyle(
                      fontWeight: rank == 1 ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

}
