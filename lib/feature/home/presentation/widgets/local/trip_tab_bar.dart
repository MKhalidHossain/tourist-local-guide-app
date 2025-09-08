import 'package:flutter/material.dart';

class TripTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TripTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Upcoming', 'Completed', 'Cancelled'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabs.length, (index) {
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: _TabChip(
              label: tabs[index],
              selected: selectedIndex == index,
            ),
          );
        }),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.4,
      height: 40,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : const Color(0xFFBFBFBF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
