import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BookingTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;


   BookingTabBar({super.key, required this.selectedIndex, required this.onTabSelected}); 
 
 
 
 
 // 0 = Upcoming, 1 = Completed, 2 = Cancelled
  // @override
//   Widget build(BuildContext context) {
//     final bookings = getBookingsForTab(selectedTab);

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _TabChip(label: 'Upcoming', selected: true),
//           const SizedBox(width: 8),
//           _TabChip(label: 'Completed'),
//           const SizedBox(width: 8),
//           _TabChip(label: 'Cancelled'),
//         ],
//       ),
//     );
//   }
// }

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
      height: 25,
      decoration: BoxDecoration(
        color:
            selected
                ? AppColors.context(context).primaryColor
                : Color(0xFFBFBFBF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}




//  List<Widget> getBookingsForTab(int tabIndex) {
//     // For demo, return static cards based on tab
//     if (tabIndex == 0) {
//       return List.generate(
//         4,
//         (index) => BookingCard(
//           name: 'Jerome Bell',
//           country: 'China',
//           imageUrl: 'assets/images/user.png',
//           category: 'Restaurant',
//           dateTime: '9:00 AM, 11/06/25',
//           people: '04 People',
//           price: '\$125.00',
//           actionButton: SecondaryButton(
//             onPressed: () {
//               // handle tap
//             },
//           ),
//         ),
//       );
//     } else if (tabIndex == 1) {
//       return List.generate(
//         2,
//         (index) => BookingCard(
//           name: 'Esther Howard',
//           country: 'Japan',
//           imageUrl: 'assets/images/user.png',
//           category: 'Hotel',
//           dateTime: '10:30 AM, 09/06/25',
//           people: '02 People',
//           price: '\$200.00',
//           actionButton: const SizedBox.shrink(),
//         ),
//       );
//     } else {
//       return [];
//     }
//   }

