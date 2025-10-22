import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/normal_custom_button.dart';
import 'package:kobeur/feature/booking_module/presentation/screens/booking_offer_summery.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:kobeur/utils/display_helper.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../home/domain/tourist/get_offer_details_response_model.dart';

// ignore: must_be_immutable
class OfferDetailsScreenForTouristScreen extends StatefulWidget {
  String localID;
  String offerId;

  OfferDetailsScreenForTouristScreen({
    Key? key,
    required this.localID,
    required this.offerId,
  }) : super(key: key);

  @override
  _OfferDetailsScreenForTouristScreenState createState() =>
      _OfferDetailsScreenForTouristScreenState();
}

class _OfferDetailsScreenForTouristScreenState
    extends State<OfferDetailsScreenForTouristScreen> {
  late HomeController homeController;
  int selectedImageIndex = 0;
  int? selectedDateIndex;
  String? selectedDate;
  String? selectedTime;
  List<Availability>? availableDates;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Future.delayed(const Duration(seconds: 2)).then((_) {
      homeController.getOfferDetails(widget.localID, widget.offerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      builder: (homeController) {
        final local = homeController.getOfferDetailsResponseModel.data?.local;
        final offer = homeController.getOfferDetailsResponseModel.data?.offer;
        final avgRatting = local?.averageRating;
        availableDates = offer?.availability;
        return homeController.isLoading
            ? buildShimmer(context)
            : Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: size.height * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                color:
                                    Colors.grey[300], // fallback shimmer base
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                child:
                                    offer?.photos != null &&
                                            offer!.photos!.isNotEmpty &&
                                            selectedImageIndex <
                                                offer.photos!.length &&
                                            offer
                                                .photos![selectedImageIndex]
                                                .isNotEmpty
                                        ? Image.network(
                                          offer.photos![selectedImageIndex],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: size.height * 0.35,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.white,
                                                width: double.infinity,
                                                height: size.height * 0.35,
                                              ),
                                            );
                                          },
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Image.asset(
                                              'assets/images/bannerPlaceholder.jpg',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: size.height * 0.35,
                                            );
                                          },
                                        )
                                        : Image.asset(
                                          'assets/images/bannerPlaceholder.jpg',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: size.height * 0.35,
                                        ),
                              ),
                            ),
                            Positioned(
                              top: size.height * 0.07,
                              left: size.width * 0.07,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Rating and Title
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      avgRatting?.toInt() ?? 0,
                                      (index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  '(${avgRatting?.toStringAsFixed(1)})'
                                      .text14Grey(),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                offer?.title ?? '',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),

                              // Image Gallery - Clickable thumbnails
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: offer?.photos?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final photo = offer!.photos![index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImageIndex = index;
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.2,
                                        height: 70,
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color:
                                                selectedImageIndex == index
                                                    ? Colors.red
                                                    : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child:
                                              (photo.isNotEmpty)
                                                  ? Image.network(
                                                    photo,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (
                                                      context,
                                                      child,
                                                      loadingProgress,
                                                    ) {
                                                      if (loadingProgress ==
                                                          null)
                                                        return child;
                                                      return Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[100]!,
                                                        child: Container(
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    },
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Image.asset(
                                                        'assets/images/bannerPlaceholder.jpg',
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                  : Image.asset(
                                                    'assets/images/bannerPlaceholder.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: 20),

                              // Description
                              Text(
                                offer?.description ??
                                    'No Description Available',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 100),
                              // ✅ Available Dates & Times Section
                              if (offer?.availability != null &&
                                  offer!.availability!.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Available Dates",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Dates in a Wrap (instead of horizontal list)
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children:
                                          availableDates!.asMap().entries.map((
                                            entry,
                                          ) {
                                            final index = entry.key;
                                            final availability = entry.value;

                                            final date = DateTime.tryParse(
                                              availability.date ?? " ",
                                            );
                                            final formattedDate =
                                                date != null
                                                    ? "${date.day}/${date.month}/${date.year}"
                                                    : "Invalid Date";

                                            final isSelected =
                                                selectedDateIndex == index;

                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedDateIndex = index;
                                                  selectedDate =
                                                      entry.value.date;
                                                  print(
                                                    "Selected Date: $selectedDate",
                                                  );
                                                  selectedTime = null;
                                                });
                                              },
                                              child: Container(
                                                width:
                                                    (MediaQuery.of(
                                                              context,
                                                            ).size.width -
                                                            10) /
                                                        3 -
                                                    20, // ~3 per row
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10,
                                                    ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    width: isSelected ? 2 : 1,
                                                    color:
                                                        isSelected
                                                            ? const Color(
                                                              0xffFF3951,
                                                            )
                                                            : Colors.grey[300]!,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    formattedDate,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          isSelected
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),

                                    const SizedBox(height: 20),

                                    // Show times when a date is selected
                                    if (selectedDateIndex != null) ...[
                                      const Text(
                                        "Selected a Time Slots",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      // Times in a wrap (2–3 per row depending on width)
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children:
                                            availableDates![selectedDateIndex!]
                                                .timeSlots!
                                                .map((time) {
                                                  final isSelected =
                                                      selectedTime == time;
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedTime = time;
                                                        print(
                                                          "Selected Time: $selectedTime",
                                                        );
                                                      });
                                                    },
                                                    child: Container(
                                                      width:
                                                          (MediaQuery.of(
                                                                    context,
                                                                  ).size.width -
                                                                  10) /
                                                              3 -
                                                          20, // ~3 per row
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 10,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            isSelected
                                                                ? Colors.red
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          time,
                                                          style: TextStyle(
                                                            color:
                                                                isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                                .toList(),
                                      ),

                                      const SizedBox(height: 16),

                                      // Total count of slots
                                      Text(
                                        "Total Slots: ${availableDates![selectedDateIndex!].timeSlots?.length ?? 0}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
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
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(
                  top: 8,
                  left: 24,
                  right: 24,
                  bottom: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\$${offer?.pricePerPerson}/hour',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    NormalCustomButton(
                      height: 40,
                      weight: 130,
                      showIcon: true,
                      sufixIcon: Icons.calendar_today_outlined,
                      text: 'Book Now',
                      onPressed: () {
                        print("Selected Date ${selectedDate}");
                        print("Selected Time ${selectedTime}");
                        if (selectedDate != null && selectedTime != null) {
                          Get.to(
                            BookingOfferSummaryScreen(
                              offer: offer!,
                              local: local!,
                              userSelectedDateForBooking:
                                  selectedDate ?? '00/00/0000',
                              userSelectedTimeForBooking:
                                  selectedTime ?? '00:00',
                            ),
                          );
                        } else {
                          showCustomSnackBar(
                            'Please select date and time for booking',
                          );
                        }
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

Widget buildShimmer(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Banner Image
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: size.height * 0.35,
              color: Colors.white,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating placeholder
                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(Icons.star, size: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title placeholder
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: size.width * 0.6,
                    height: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Image thumbnails placeholder
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width * 0.2,
                        height: 70,
                        margin: const EdgeInsets.only(right: 8),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Description placeholder
                Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

    // Bottom Button placeholder
    bottomNavigationBar: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Price placeholder
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(width: 50, height: 14, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(width: 80, height: 20, color: Colors.white),
              ),
            ],
          ),

          // Button placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 130,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
