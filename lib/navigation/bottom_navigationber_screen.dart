import 'package:flutter/material.dart';
import 'package:kobeur/feature/home/presentation/screens/tourist/tourist_booking_screen.dart';
import '../core/themes/app_color.dart';
import '../feature/home/presentation/screens/local/local_home_screen.dart';
import '../feature/home/presentation/screens/local/local_trip_screen.dart';
import '../feature/home/presentation/screens/tourist/tourist_home_screen.dart';
import '../feature/chat/presentation/screens/message_screen.dart';
import '../feature/profile/presentation/screens/profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  final String? userRole;
  const BottomNavbar({super.key, required this.userRole});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      (widget.userRole?.toLowerCase() == 'tourist'
          ? TouristHomeScreen()
          : LocalHomeScreen()),
      (widget.userRole?.toLowerCase() == 'tourist'
          ? TouristBookingScreen()
          : LocalTripScreen()),
      MessagesScreen(),
      ProfileScreen(userRole: widget.userRole.toString(),),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 85,
            padding: EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final isSelected = index == _selectedIndex;

                final icons = [
                  Icons.home_filled,
                  Icons.calendar_today,
                  Icons.chat_bubble_outline,
                  Icons.person_2,
                ];
                //       final icons = [
                //   'assets/icons/home.png',
                //   'assets/icons/calendar.png',
                //   'assets/icons/chat.png',
                //   'assets/icons/profile.png',
                // ];
                final labels = [
                  'Home',
                  widget.userRole == 'tourist' ? 'Bookings' : 'My Trip',
                  'Messages',
                  'Profile',
                ];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 12 : 0,
                      vertical: 8,
                    ),
                    decoration:
                        isSelected
                            ? BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(24),
                            )
                            : null,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 30,
                          child: Icon(
                            icons[index],
                            size: 26,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        if (isSelected) const SizedBox(width: 8),
                        if (isSelected)
                          Text(
                            labels[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
