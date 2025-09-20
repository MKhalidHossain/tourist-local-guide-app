import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/widgets/formatTripDateText.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/extensions/text_extensions.dart';
import '../../../../chat/presentation/screens/chat_screen.dart';
import '../../../../home/controllers/home_controller.dart';

class LocalTripDetailsScreen extends StatefulWidget {
  final String? tripId;
  final String? bookingId;

  const LocalTripDetailsScreen({super.key, this.tripId, this.bookingId});

  @override
  State<LocalTripDetailsScreen> createState() => _LocalTripDetailsScreenState();
}

// tripId: trip.id,
class _LocalTripDetailsScreenState extends State<LocalTripDetailsScreen> {
  late HomeController localHomeController;

  final instructions = [
    'Bring comfortable walking shoes and weather appropriate clothing.',
    'Your local guide will be wearing a blue badge for easy identification.',
    'Please arrive at the point 5 minutes before the scheduled time.',
  ];

  String formatTripDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "0:00 AM, 00/00/00";
    }
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat("h:mm a, dd/MM/yy").format(parsedDate.toLocal());
    } catch (e) {
      return "0:00 AM, 00/00/00";
    }
  }

  @override
  void initState() {
    super.initState();
    localHomeController = Get.find<HomeController>();

    // Defer the asynchronous call to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tripId != null) {
        localHomeController.getBookingDetails(widget.tripId!);
      } else {
        Get.snackbar('Error', 'Invalid trip ID');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final bookingDetails = controller.getBookingDetailsResponseModel.data;

        // Handle loading and error states
        if (controller.isLoading == true) {
          return AppScaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: 'Trip Details'.text24Black(),
              centerTitle: false,
              elevation: 0,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (bookingDetails == null) {
          return AppScaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: 'Booking Details'.text24Black(),
              centerTitle: false,
              elevation: 0,
            ),
            body: const Center(child: Text('No booking details available')),
          );
        }

        return AppScaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: 'Booking Details'.text24Black(),
            centerTitle: false,
            elevation: 0,
          ),
          body: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Booking:'.text16Black(),
                    (bookingDetails.trip?.booking?.bookingCode ??
                            '# RES-2000-0000')
                        .text16Black(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundImage:
                    //       bookingDetails.trip?.touristId?.profileImage != null
                    //           ? NetworkImage(
                    //             bookingDetails.trip?.touristId?.profileImage ??
                    //                 '',
                    //           )
                    //           : const AssetImage('assets/images/user.png')
                    //               as ImageProvider,
                    // ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      child: ClipOval(
                        child:
                            (bookingDetails.trip?.touristId?.profileImage !=
                                        null &&
                                    (bookingDetails
                                            .trip
                                            ?.touristId
                                            ?.profileImage
                                            ?.isNotEmpty ??
                                        false))
                                ? Image.network(
                                  bookingDetails.trip!.touristId!.profileImage!,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/profileBlankImage.png',
                                      fit: BoxFit.cover,
                                      width: 70,
                                      height: 70,
                                    );
                                  },
                                )
                                : Image.asset(
                                  'assets/images/profileBlankImage.png',
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ('${bookingDetails.trip?.touristId?.firstName ?? 'No'} ${bookingDetails.trip?.touristId?.lastName ?? ''}')
                              .text14Black600(),
                          (bookingDetails.trip?.touristId?.location ?? 'N/A')
                              .text14Grey(),
                        ],
                      ),
                    ),
                    SecondaryButton(
                      width: 110,
                      height: 40,
                      fontSize: 14,
                      text: 'Message',
                      onPressed: () {
                        Get.to(() => ChatScreen());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                (bookingDetails.trip?.offerId?.category ?? 'N/A')
                    .text16Black600(),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (bookingDetails.trip?.offerId?.offerType ?? 'N/A')
                              .text14Black600(),
                          '\$${bookingDetails.trip?.totalAmount?.toStringAsFixed(2) ?? '0.00'}'
                              .text16LightRed(),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.black,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              // formatTripDate(bookingDetails.trip?.date).text14Black(),
                              FormatTripDateText(
                                dateStr: bookingDetails.trip?.date.toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/persons.png',
                                height: 14,
                              ),
                              const SizedBox(width: 4),
                              '${bookingDetails.trip?.participants?.toString().padLeft(2, '0') ?? '00'} People'
                                  .text14Black(),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 110,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image:
                                      bookingDetails
                                                  .trip
                                                  ?.offerId
                                                  ?.photos
                                                  ?.isNotEmpty ??
                                              false
                                          ? NetworkImage(
                                            bookingDetails
                                                .trip!
                                                .offerId!
                                                .photos!
                                                .first,
                                          )
                                          : const AssetImage(
                                            'assets/images/nanchanTemple.png',
                                          ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (bookingDetails.trip?.offerId?.title ?? 'N/A')
                                      .text14Black600(),
                                  (bookingDetails.trip?.offerId?.category ??
                                          'N/A')
                                      .text14Grey(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffEAB308),
                                            size: 16,
                                          ),
                                          '5(4.8)'
                                              .text12Black(), // Consider dynamic rating
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          '\$${bookingDetails.trip?.offerId?.pricePerPerson?.toStringAsFixed(2) ?? '0.00'}'
                                              .text16LightRed(),
                                          '/person'.text12Black(),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                'Important Information'.text16Black600(),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      instructions
                          .map(
                            (text) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '•',
                                    style: TextStyle(
                                      fontSize: 20,
                                      height: 1.4,
                                      color: Color(0xFF4D4D4D),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                        color: Color(0xFF4D4D4D),
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                ),
                const Spacer(),
                SecondaryButton(
                  width: double.infinity,
                  text: 'Cancel Booking',
                  onPressed: () {
                    localHomeController.cencelBooking(
                      widget.bookingId.toString(),
                    );
                    // Get.snackbar('Info', 'Cancel Booking not implemented');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kobeur/core/common/button/button_widget.dart';
// import '../../../../../core/widgets/app_scaffold.dart';
// import '../../../../../core/extensions/text_extensions.dart';
// import '../../../../chat/tourist/message/presentation/screens/chat_screen.dart';
// import '../../../../home/controllers/local_home_controller.dart';
// import '../../../../home/domain/local/get_booking_details_response_model.dart';


// class BookingDetailsScreen extends StatefulWidget {
//   String? tripId;

//   BookingDetailsScreen({super.key,  this.tripId});

//   @override
//   State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
//   late LocalHomeTripController localHomeController;

//   final instructions = [
//     'Bring comfortable walking shoes and weather appropriate clothing.',
//     'Your local guide will be wearing a blue badge for easy identification.',
//     'Please arrive at the point 5 minutes before the scheduled time.',
//   ];

//   String formatTripDate(String? dateStr) {
//     if (dateStr == null || dateStr.isEmpty) {
//       return "0:00 AM, 00/00/00";
//     }

//     try {
//       DateTime parsedDate = DateTime.parse(dateStr);
//       String formattedDate = DateFormat(
//         "h:mm a, dd/MM/yy",
//       ).format(parsedDate.toLocal());
//       return formattedDate;
//     } catch (e) {
//       return "0:00 AM, 00/00/00";
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     localHomeController = Get.find<LocalHomeTripController>();
//     localHomeController.getBookingDetails(widget.tripId!);

//     print(
//       "Booking Details Screen (initState): Upcoming Trips: ${localHomeController.getBookingDetailsResponseModel.data?.touristName}",
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LocalHomeTripController>(
//       builder: (localHomeController) {

//         return AppScaffold(
//           appBar: AppBar(
//             leading: const BackButton(),
//             title: 'Booking Details'.text24Black(),
//             centerTitle: false,
//             elevation: 0,
//           ),
//           body: SafeArea(
//             top: false,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     'Booking:'.text16Black(),
//                     '# RES-2023-7845'.text16Black(),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const CircleAvatar(
//                       radius: 20,
//                       backgroundImage: AssetImage('assets/images/user.png'),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // "${widget.bookingDetails?.touristName}"
//                           //     .text14Black600(),
//                           // '${widget.bookingDetails?.touristCountry}'
//                           //     .text14Grey(),
//                         ],
//                       ),
//                     ),
//                     SecondaryButton(
//                       width: 110,
//                       height: 40,
//                       fontSize: 14,
//                       text: 'Message',
//                       onPressed: () {
//                         Get.to(() => ChatScreen());
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 // '${widget.bookingDetails?.offerId?.category}?.'
//                 //     .text16Black600(),
//                 const SizedBox(height: 12),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // '${widget.bookingDetails?.offerId?.offerType}'
//                           //     .text14Black600(),
//                           // "\$${widget.bookingDetails?.offerId!.pricePerPerson?.toStringAsFixed(2) ?? 'no data'}"
//                           //     .text16LightRed(),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.calendar_today_outlined,
//                                 color: Colors.black,
//                                 size: 14,
//                               ),
//                               const SizedBox(width: 4),
//                               // '${formatTripDate(widget.bookingDetails?.date)}'
//                               //     .text14Black(),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Image.asset(
//                                 'assets/icons/persons.png',
//                                 height: 14,
//                               ),
//                               const SizedBox(width: 4),
//                               // '${widget.bookingDetails?.participants.toString().padLeft(2, '0')} People'
//                               //     .text14Black(),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         width: double.infinity,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey.shade300,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 110,
//                               height: 80,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 image: const DecorationImage(
//                                   image: AssetImage(
//                                     'assets/images/nanchanTemple.png',
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   'Nanchan Temple'.text14Black600(),
//                                   'City Tour'.text14Grey(),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           const Icon(
//                                             Icons.star,
//                                             color: Color(0xffEAB308),
//                                             size: 16,
//                                           ),
//                                           '5(4.8)'.text12Black(),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           '\$30'.text16LightRed(),
//                                           '/hour'.text12Black(),
//                                           const SizedBox(width: 8),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 'Important Information'.text16Black600(),
//                 const SizedBox(height: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children:
//                       instructions
//                           .map(
//                             (text) => Padding(
//                               padding: const EdgeInsets.only(bottom: 8),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     '•',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       height: 1.4,
//                                       color: Color(0xFF4D4D4D),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Expanded(
//                                     child: Text(
//                                       text,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         height: 1.4,
//                                         color: Color(0xFF4D4D4D),
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                           .toList(),
//                 ),
//                 const Spacer(),

//                 SecondaryButton(
//                   width: double.infinity,

//                   text: 'Cancel Booking',
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
