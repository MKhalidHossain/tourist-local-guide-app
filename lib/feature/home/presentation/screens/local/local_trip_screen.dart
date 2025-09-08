import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/local_home_controller.dart';
import '../../widgets/local/trip_card.dart';
import '../../widgets/local/trip_tab_bar.dart';
class LocalTripScreen extends StatefulWidget {
  const LocalTripScreen({super.key});

  @override
  State<LocalTripScreen> createState() => _LocalTripScreenState();
}

class _LocalTripScreenState extends State<LocalTripScreen> {
  int selectedTab = 0;
  late LocalHomeTripController tripController;

  @override
  void initState() {
    super.initState();
    tripController = Get.find<LocalHomeTripController>();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tripController.getBookings('upcoming');

    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalHomeTripController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text(
              'My Trips',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              TripTabBar(
                selectedIndex: selectedTab,
                onTabSelected: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                  
                  String status;
                  switch (index) {
                    case 0:
                      status = 'upcoming';
                      break;
                    case 1:
                      status = 'completed';
                      break;
                    case 2:
                      status = 'cancelled';
                      break;
                    default:
                      status = 'upcoming';
                  }
                  
                  controller?.getBookings(status);
                  
                  debugPrint("🔄 Tab $index selected, fetching $status trips");
                },
              ),
              
              Expanded(
  child: controller.isLoading
      ? const Center(child: CircularProgressIndicator())
      //: 
          // ? Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // Text(
          //         //   controller.errorMessage ?? "Error occurred",
          //         //   style: TextStyle(
          //         //     fontSize: 16,
          //         //     color: Colors.grey[600],
          //         //   ),
          //         //   textAlign: TextAlign.center,
          //         // ),
          //         const SizedBox(height: 16),
          //         ElevatedButton(
          //           onPressed: () {
          //             String status = selectedTab == 0
          //                 ? 'upcoming'
          //                 : selectedTab == 1
          //                     ? 'completed'
          //                     : 'cancelled';
          //             controller.getBookings(status);
          //           },
          //           child: const Text('Retry'),
          //         ),
          //       ],
          //     ),
          //   )
          : _buildTabContent(),
)

            ],
          ),
        );
      },
    );
  }

  Widget _buildTabContent() {
    final trips = tripController.getCurrentTabData(selectedTab);

    if (trips.isEmpty) {
      String emptyMessage;
      switch (selectedTab) {
        case 0:
          emptyMessage = 'No upcoming trips found!';
          break;
        case 1:
          emptyMessage = 'No completed trips found!';
          break;
        case 2:
          emptyMessage = 'No cancelled trips found!';
          break;
        default:
          emptyMessage = 'No trips found!';
      }

      return Center(
        child: Text(
          emptyMessage,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: trips.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final trip = trips[index];
        return TripCard(
          trip: trip,
          onTap: () {
            // Navigate to trip details
            debugPrint("🔍 Tapped on trip: ${trip.id}");
          },
          actionButton: selectedTab == 0
              ? ElevatedButton(
                  onPressed: () {
                    // Cancel booking for upcoming trips
                    // if (trip.id != null) {
                    //   tripController.cancelBooking(trip.id!);
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancel'),
                )
              : selectedTab == 1
                  ? ElevatedButton(
                      onPressed: () {
                        // Rate completed trip
                        debugPrint("⭐ Rate trip: ${trip.id}");
                      },
                      child: const Text('Rate'),
                    )
                  : null,
        );
      },
    );
  }
}

  /// Dynamic content based on tab index
  // Widget _buildTabContent(int index, final String dateTime) {
  //   switch (index) {
  //     case 0:
  //       return GestureDetector(
  //         onTap: () => Get.to(() => BookingDetailsScreen()),
  //         child: ListView.separated(
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           itemCount: 5,
  //           separatorBuilder: (_, __) => const SizedBox(height: 12),
  //           itemBuilder:
  //               (_, index) => BookingCard(
  //                 name: 'Jerome Bell',
  //                 country: 'China',
  //                 imageUrl: 'assets/images/user.png',
  //                 category: 'Restaurant',
  //                 dateTime: dateTime.toString(),
  //                 people: '04 People',
  //                 price: '\$125.00',
  //                 actionButton: SecondaryButton(
  //                   onPressed: () {
  //                     Get.to(() => ChatScreen());
  //                   },
  //                 ),
  //               ),
  //         ),
  //       );
  //     case 1:
  //       return GestureDetector(
  //         onTap: () => Get.to(() => BookingDetailsScreen()),
  //         child: ListView.separated(
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           itemCount: 3,
  //           separatorBuilder: (_, __) => const SizedBox(height: 12),
  //           itemBuilder:
  //               (_, index) => BookingCard(
  //                 name: 'Courtney Henry',
  //                 country: 'Japan',
  //                 imageUrl: 'assets/images/user.png',
  //                 category: 'Hotel',
  //                 dateTime: dateTime.toString(),
  //                 people: '02 People',
  //                 price: '\$200.00',
  //                 actionButton: SecondaryButton(
  //                   onPressed: () {
  //                     Get.to(() => ChatScreen());
  //                   },
  //                 ),
  //               ),
  //         ),
  //       );
  //     case 2:
  //       return Center(child: 'No cancelled Trip yet!'.text16Grey());
  //     default:
  //       return Center(child: 'Unknown Tab'.text16Grey());
  //   }
  // }
//}

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
