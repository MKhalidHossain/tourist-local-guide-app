import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/chat/presentation/screens/chat_screen.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import '../../../../../core/common/button/button_widget.dart';
import '../../../../trip_module/presentation/screens/tourist/tourist_booking_details_screen.dart';
import '../../../../trip_module/presentation/widgets/bookingtabber_widget.dart';
import '../../../../trip_module/presentation/widgets/upcoming_cart_widget.dart';

class TouristBookingScreen extends StatefulWidget {
  const TouristBookingScreen({super.key});

  @override
  State<TouristBookingScreen> createState() => _TouristBookingScreenState();
}

class _TouristBookingScreenState extends State<TouristBookingScreen> {
  int selectedTab = 0;
  late HomeController localTripController;
  String? liveTripId;

  @override
  void initState() {
    super.initState();
    localTripController = Get.find<HomeController>();
    // Load default tab (Upcoming)
    localTripController.getBookings("upcoming");

    // localTripController.getHome();
    // liveTripId = localTripController.getHomeResponseModel.data?.liveTrip?.id;
    // if (liveTripId != null) {
    //   localTripController.getBookingDetails(liveTripId!);
    // }

    print(
      "Local Trip Screen (initState): Upcoming Trips: ${localTripController.getHomeResponseModel.data?.upcomingTrips?.length ?? 0}",
    );
    print(
      "Local Trip Screen (initState): Total Tours: ${localTripController.getHomeResponseModel.data?.totalTours ?? 0}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (localTripController) {
        return localTripController.isLoading
            ? Scaffold(
              appBar: AppBar(
                title: 'My Bookings'.text24Black(),
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
              body: const Center(child: CircularProgressIndicator()),
            )
            : Scaffold(
              appBar: AppBar(
                title: 'My Bookings'.text24Black(),
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
                      if (index == 0) {
                        localTripController.getBookings("upcoming");
                      } else if (index == 1) {
                        localTripController.getBookings("completed");
                      } else if (index == 2) {
                        localTripController.getBookings("cancelled");
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Content Area
                  Expanded(child: _buildTabContent(selectedTab)),
                ],
              ),
            );
      },
    );
  }

  Widget _buildTabContent(int index) {
    final bookings =
        localTripController.getTripResponseApiBookingsModel.data ?? [];

    if (bookings.isEmpty) {
      return Center(child: "No trips found!".text16Grey());
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final trip = bookings[i];
        return GestureDetector(
          onTap:
              () => Get.to(
                () => TouristBookingDetailsScreen(
                  tripId: trip.id,
                  bookingId: trip.booking?.id, // Pass whole Trip object
                ),
              ),
          child: BookingCard(
            name:
                "${trip.touristId?.firstName ?? ''} ${trip.touristId?.lastName ?? ''}",
            country: trip.touristId?.location ?? "Unknown",
            imageUrl: trip.touristId?.profileImage ?? 'assets/images/user.png',
            category: trip.offerId?.category ?? "N/A",
            dateTime: trip.date?.toIso8601String() ?? "",
            people: "${trip.participants ?? 0} People",
            price: "\$${trip.totalAmount ?? 0}",
            actionButton: SecondaryButton(
              onPressed: () {
                Get.to(() => ChatScreen());
              },
            ),
          ),
        );
      },
    );
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
}
