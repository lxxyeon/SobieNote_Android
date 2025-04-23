import 'package:flutter/material.dart';

class TopSheetSelector extends StatelessWidget {
  final bool isVisible;
  final double topOffset;
  final int selectedMonth;
  final int selectedYear;
  final int tabIndex;
  final Function(int) onMonthSelected;
  final Function(int) onYearSelected;

  const TopSheetSelector({
    super.key,
    required this.isVisible,
    required this.topOffset,
    required this.selectedMonth,
    required this.selectedYear,
    required this.tabIndex,
    required this.onMonthSelected,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return SizedBox.shrink();

    return Positioned(
      top: topOffset,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child:
          tabIndex == 0
              ? _buildGrid(context, 12, (i) => '${i + 1}월', selectedMonth, onMonthSelected)
              : _buildGrid(context, 12, (i) => '${2014 + i}년', selectedYear, onYearSelected),

        ),
      ),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    int count,
    String Function(int) labelBuilder,
    int selectedValue,
    Function(int) onSelect,
  ) {
    return GridView.builder(
      itemCount: count,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, i) {
        final isSelected =
            selectedValue ==
            (labelBuilder == null ? i : (tabIndex == 0 ? i + 1 : 2014 + i));
        return GestureDetector(
          onTap: () => onSelect(tabIndex == 0 ? i + 1 : 2014 + i),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              labelBuilder(i),
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      },
    );
  }
}
