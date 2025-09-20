import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/chat/presentation/screens/chat_screen.dart';
import '../../../../core/common/button/button_widget.dart';
import '../../../trip_module/presentation/widgets/bookingtabber_widget.dart';
import '../../../trip_module/presentation/widgets/upcoming_cart_widget.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: 'My Trip'.text24Black(),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          /// Tab Bar Widget
          BookingTabBar(
            selectedIndex: selectedTab,
            onTabSelected: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),

          const SizedBox(height: 12),

          /// Content Area
          Expanded(child: _buildTabContent(selectedTab)),
        ],
      ),
    );
  }

  /// Dynamic content based on tab index
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return GestureDetector(
          onTap: () {},
          //  => Get.to(() => BookingDetailsScreen()),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder:
                (_, index) => BookingCard(
                  name: 'Jerome Bell',
                  country: 'China',
                  imageUrl: 'assets/images/user.png',
                  category: 'Restaurant',
                  dateTime: '9:00 AM, 11/06/25',
                  people: '04 People',
                  price: '\$125.00',
                  actionButton: SecondaryButton(
                    onPressed: () {
                      Get.to(() => ChatScreen());
                    },
                  ),
                ),
          ),
        );
      case 1:
        return GestureDetector(
          onTap: () {},
          //  => Get.to(() => BookingDetailsScreen()),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder:
                (_, index) => BookingCard(
                  name: 'Courtney Henry',
                  country: 'Japan',
                  imageUrl: 'assets/images/user.png',
                  category: 'Hotel',
                  dateTime: '7:00 PM, 08/06/25',
                  people: '02 People',
                  price: '\$200.00',
                  actionButton: SecondaryButton(
                    onPressed: () {
                      Get.to(() => ChatScreen());
                    },
                  ),
                ),
          ),
        );
      case 2:
        return Center(child: 'No cancelled Trip yet!'.text16Grey());
      default:
        return Center(child: 'Unknown Tab'.text16Grey());
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/feature/booking/presentation/screens/booking_details_screen.dart';

// import '../../../../core/common/button/button_widget.dart';
// import '../widgets/bookingtabber_widget.dart';
// import '../widgets/upcoming_cart_widget.dart';

// class BookingsPage extends StatefulWidget {
//   const BookingsPage({super.key});

//   @override
//   State<BookingsPage> createState() => _BookingsPageState();
// }

// class _BookingsPageState extends State<BookingsPage> {
//   int selectedTab = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         title: const Text('My Bookings', style: TextStyle(color: Colors.black)),
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//           /// Tab Bar Widget
//           BookingTabBar(
//             selectedIndex: selectedTab,
//             onTabSelected: (index) {
//               setState(() {
//                 selectedTab = index;
//               });
//             },
//           ),

//           const SizedBox(height: 12),

//           /// Content Area
//           Expanded(child: _buildTabContent(selectedTab)),
//         ],
//       ),
//     );
//   }

//   /// Dynamic content based on tab index
//   Widget _buildTabContent(int index) {
//     switch (index) {
//       case 0:
//         // Tab 0: Upcoming Bookings
//         return GestureDetector(
//           onTap: () => Get.to(() => BookingDetailsScreen()),
//           child: ListView.separated(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             itemCount: 5,
//             separatorBuilder: (_, __) => const SizedBox(height: 12),
//             itemBuilder:
//                 (_, index) => BookingCard(
//                   name: 'Jerome Bell',
//                   country: 'China',
//                   imageUrl: 'assets/images/user.png',
//                   category: 'Restaurant',
//                   dateTime: '9:00 AM, 11/06/25',
//                   people: '04 People',
//                   price: '\$125.00',
//                   actionButton: SecondaryButton(
//                     // text: "Cancel",
//                     onPressed: () {
//                       // Get.to(() => BookingDetailsScreen());
//                       //Get.to(BookingDetailsScreen());
//                     },
//                   ),
//                 ),
//           ),
//         );

//       case 1:
//         // Tab 1: Completed Bookings
//         return ListView.separated(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           itemCount: 3,
//           separatorBuilder: (_, __) => const SizedBox(height: 12),
//           itemBuilder:
//               (_, index) => BookingCard(
//                 name: 'Courtney Henry',
//                 country: 'Japan',
//                 imageUrl: 'assets/images/user.png',
//                 category: 'Hotel',
//                 dateTime: '7:00 PM, 08/06/25',
//                 people: '02 People',
//                 price: '\$200.00',
//                 actionButton: SecondaryButton(
//                   // text: "Rate",
//                   onPressed: () {
//                     // Handle rating
//                   },
//                 ),
//               ),
//         );

//       case 2:
//         // Tab 2: Cancelled Bookings
//         return Center(
//           child: Text(
//             "No cancelled bookings yet!",
//             style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//           ),
//         );

//       default:
//         return Center(child: Text("Unknown Tab"));
//     }
//   }
// }

// // import 'package:flutter/material.dart';

// // import '../../../../core/common/button/button_widget.dart';
// // import '../widgets/bookingtabber_widget.dart';
// // import '../widgets/upcoming_cart_widget.dart';

// // class BookingsPage extends StatefulWidget {
// //   const BookingsPage({super.key});

// //   @override
// //   State<BookingsPage> createState() => _BookingsPageState();
// // }

// // class _BookingsPageState extends State<BookingsPage> {
// //   int selectedTab = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F5F5),
// //       appBar: AppBar(
// //         title: const Text('My Bookings', style: TextStyle(color: Colors.black)),
// //         centerTitle: false,
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: Column(
// //         children: [
// //           BookingTabBar(
// //             selectedIndex: selectedTab,
// //             onTabSelected: (index) {
// //               setState(() {
// //                 selectedTab = index;
// //               });
// //             },
// //           ),
// //           const SizedBox(height: 12),

// //           Expanded(
// //             child: ListView.separated(
// //               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               itemCount: 9,
// //               separatorBuilder: (_, __) => const SizedBox(height: 12),
// //               itemBuilder:
// //                   (_, index) => BookingCard(
// //                     name: 'Jerome Bell',
// //                     country: 'China',
// //                     imageUrl: 'assets/images/user.png',
// //                     category: 'Restaurant',
// //                     dateTime: '9:00 AM, 11/06/25',
// //                     people: '04 People',
// //                     price: '\$125.00',
// //                     actionButton: SecondaryButton(
// //                       onPressed: () {
// //                         // handle tap
// //                       },
// //                     ),
// //                   ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
