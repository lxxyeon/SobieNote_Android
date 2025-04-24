import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/common/const/text_style.dart';

class ReportCategory extends StatelessWidget {
  const ReportCategory({super.key});

  final List<String> leftCategories = const [
    '식품',
    '패션',
    '디지털',
    '미용',
    '반려동물',
    '스포츠/캠핑',
    '인테리어',
  ];

  final List<String> rightCategories = const [
    '도서',
    '자동차',
    '가전',
    '건강',
    '스포츠/캠핑',
    '취미',
    '여행',
  ];

  @override
  Widget build(BuildContext context) {
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
                child: _buildColumn(
                  leftCategories,
                  CrossAxisAlignment.end,
                  TextAlign.right,
                ),
              ),
              Container(
                height: 250,
                width: 1,
                color: GRAY_06,
                margin: const EdgeInsets.symmetric(horizontal: 16), // 좌우 여백
              ),
              Expanded(
                child: _buildColumn(
                  rightCategories,
                  CrossAxisAlignment.start,
                  TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(
    List<String> categories,
    CrossAxisAlignment alignment,
    TextAlign textAlign,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: alignment,
      children:
          categories.map((title) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: textAlign,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Expanded(child: Container()),
                  const Text('0', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
    );
  }
}
