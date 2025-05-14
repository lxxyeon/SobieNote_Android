import 'package:flutter/material.dart';

import '../common/const/colors.dart';
import 'btn_tag.dart';

class TagSelector extends StatelessWidget {
  final String title;
  final List<String> tagList;
  final int? selectedIndex;
  final Function(int) onTagSelected;

  const TagSelector({
    super.key,
    required this.title,
    required this.tagList,
    required this.selectedIndex,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: GRAY_00,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children:
              tagList
                  .asMap()
                  .entries
                  .map(
                    (e) => BtnTag(
                      text: e.value,
                      selected: selectedIndex == e.key,
                      onPressed: () => onTagSelected(e.key),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
