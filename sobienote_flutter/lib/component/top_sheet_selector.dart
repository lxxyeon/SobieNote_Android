import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';

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
                  ? _buildGrid(
                    context,
                    12,
                    (i) => '${i + 1}월',
                    selectedMonth,
                    onMonthSelected,
                  )
                  : _buildGrid(
                    context,
                    12,
                    (i) => '${2014 + i}년',
                    selectedYear,
                    onYearSelected,
                  ),
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
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      childAspectRatio: 3/2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: List.generate(count, (i) {
        final int value = tabIndex == 0 ? i + 1 : 2014 + i;
        final bool isSelected = selectedValue == value;

        return GestureDetector(
          onTap: () => onSelect(value),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? DARK_TEAL : LIGHT_GRAY,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              labelBuilder(i),
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      }),
    );
  }
}
