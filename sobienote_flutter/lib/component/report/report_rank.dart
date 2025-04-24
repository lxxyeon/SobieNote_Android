import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';

import '../../common/const/text_style.dart';

class ReportRank extends StatelessWidget {
  const ReportRank({super.key});

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
    final List<Map<String, dynamic>> data = [
      {
        'rank': 1,
        'label': '기분전환',
        'count': 6,
        'asset': 'assets/images/rank1.png',
      },
      {
        'rank': 2,
        'label': '효율증가',
        'count': 5,
        'asset': 'assets/images/rank2.png',
      },
      {
        'rank': 3,
        'label': '습관개선',
        'count': 4,
        'asset': 'assets/images/rank3.png',
      },
      {'rank': 4, 'label': '취향디깅', 'count': 3},
      {'rank': 5, 'label': '자기계발', 'count': 2},
    ];

    return Column(
      children:
          data.map((item) {
            final bool isIcon = item.containsKey('asset');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              child: Row(
                children: [
                  isIcon
                      ? Image.asset(item['asset'], width: 30)
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 25,
                            height: 25,
                            color: DARK_TEAL,
                            child: Center(
                              child: Text(
                                '${item['rank']}',
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
                      item['label'],
                      style: TextStyle(
                        fontWeight:
                            item['rank'] == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    '${item['count']}',
                    style: TextStyle(
                      fontWeight:
                          item['rank'] == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
