import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/normal_custom_button.dart';
import 'package:kobeur/feature/booking_module/presentation/screens/booking_offer_summery.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getOfferDetails(widget.localID, widget.offerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final local = homeController.getOfferDetailsResponseModel.data?.local;
    final offer = homeController.getOfferDetailsResponseModel.data?.offer;
    final avgRatting = local?.averageRating;

    return GetBuilder<HomeController>(
      builder: (homeController) {
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
                                                offer.photos!.length  &&
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
                        Get.to(
                          BookingOfferSummaryScreen(
                            offer: offer!,
                            local: local!,
                          ),
                        );
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
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header image
          Container(
            width: double.infinity,
            height: size.height * 0.35,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Container(
                  width: size.width * 0.6,
                  height: 28,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                // Star rating
                Container(width: 100, height: 20, color: Colors.white),
                const SizedBox(height: 16),
                // Image thumbnails
                Row(
                  children: List.generate(4, (index) {
                    return Container(
                      width: size.width * 0.2,
                      height: 70,
                      margin: const EdgeInsets.only(right: 8),
                      color: Colors.white,
                    );
                  }),
                ),
                const SizedBox(height: 16),
                // Description
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
