import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/offer/presentation/screens/tourist/offer_details_screen_for_tourist.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../chat/presentation/screens/chat_screen.dart';

// ignore: must_be_immutable
class LocalsProfileForTouristScreen extends StatefulWidget {
  String localId;
  LocalsProfileForTouristScreen({super.key, required this.localId});

  @override
  State<LocalsProfileForTouristScreen> createState() =>
      _LocalsProfileForTouristScreenState();
}

class _LocalsProfileForTouristScreenState
    extends State<LocalsProfileForTouristScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    print("local id in profile for tourist: ${widget.localId}\n");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getLocalProfile(widget.localId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      builder: (homeController) {
        final localProfileDetails =
            homeController.getLocalProfileResponseModel.data;
        return homeController.isLoading
            ? _buildShimmerLoader(size)
            : Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: size.height * 0.12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: FadeInImage.assetNetwork(
                                width: size.width,
                                height: size.height * 0.35,
                                fit: BoxFit.cover,
                                placeholder:
                                    'assets/images/profileBlankImage.png',
                                image: localProfileDetails?.profileImage ?? '',
                                imageErrorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                                  return Image.asset(
                                    'assets/images/profileBlankImage.png',
                                    width: size.width,
                                    height: size.height * 0.35,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: size.height * 0.05,
                              left: size.width * 0.05,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: CircleAvatar(
                                  radius: size.width * 0.06,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: size.width * 0.05,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                          ),
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          transform: Matrix4.translationValues(
                            0,
                            -size.height * 0.05,
                            0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child:
                                        "${localProfileDetails?.name ?? 'Loading'}"
                                            .text20Black700(),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                      vertical: size.width * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFF3951),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: size.width * 0.035,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          localProfileDetails?.rating?.average
                                                  ?.toStringAsFixed(1) ??
                                              '4.8',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 0.03,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: size.width * 0.065,
                                    color: const Color(0xff666666),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  '${localProfileDetails?.country ?? 'Unknown'}'
                                      .text16Grey500(),
                                ],
                              ),
                              SizedBox(height: size.height * 0.005),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    size: size.width * 0.055,
                                    color: const Color(0xff666666),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Expanded(
                                    child: Row(
                                      children:
                                          localProfileDetails?.languages != null
                                              ? List.generate(
                                                localProfileDetails!
                                                    .languages!
                                                    .length,
                                                (index) => Row(
                                                  children: [
                                                    Text(
                                                      localProfileDetails
                                                          .languages![index],
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.035,
                                                      ),
                                                    ),
                                                    if (index !=
                                                        localProfileDetails
                                                                .languages!
                                                                .length -
                                                            1)
                                                      Text(", "),
                                                  ],
                                                ),
                                              )
                                              : [
                                                Text(
                                                  'No languages',
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.035,
                                                  ),
                                                ),
                                              ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.015),
                              '${localProfileDetails?.about ?? 'No description'}'
                                  .text14Grey(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Offer'.text20Black700(),
                              SizedBox(height: size.height * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    localProfileDetails?.offers != null &&
                                            localProfileDetails!
                                                .offers!
                                                .isNotEmpty
                                        ? localProfileDetails.offers!.map((
                                          offer,
                                        ) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: size.height * 0.015,
                                            ),
                                            child: _buildOfferCard(
                                              offer.title ?? "No Title",
                                              offer.description ??
                                                  "No Description",
                                              "\$${offer.pricePerPerson}",
                                              (offer.photos != null &&
                                                      offer.photos!.isNotEmpty)
                                                  ? offer.photos![0]
                                                  : "assets/images/bannerPlaceholder.jpg",
                                              () {
                                                Get.to(
                                                  () =>
                                                      OfferDetailsScreenForTouristScreen(
                                                        localID:
                                                            localProfileDetails
                                                                .id ??
                                                            "",
                                                        offerId:
                                                            offer.sId ?? "",
                                                      ),
                                                );
                                              },
                                              size,
                                            ),
                                          );
                                        }).toList()
                                        : [
                                          Center(
                                            child: Text(
                                              "No offers available",
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: size.width * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: size.width * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Column(
                                children:
                                    (localProfileDetails?.rating?.reviews !=
                                                null &&
                                            localProfileDetails!
                                                .rating!
                                                .reviews!
                                                .isNotEmpty)
                                        ? localProfileDetails.rating!.reviews!.map((
                                          review,
                                        ) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: size.height * 0.015,
                                            ),
                                            child: _buildReviewItem(
                                              review.reviewer?.name ??
                                                  "Anonymous",
                                              review.comment ?? "",
                                              review.reviewer?.profileImage ??
                                                  "assets/images/profileBlankImage.png",
                                              () {},
                                              review.rating?.toStringAsFixed(
                                                    1,
                                                  ) ??
                                                  "0.0",
                                              size,
                                            ),
                                          );
                                        }).toList()
                                        : [
                                          Text(
                                            'No reviews available',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                        bottom:
                            MediaQuery.of(context).padding.bottom +
                            size.height * 0.02,
                        left: size.width * 0.04,
                        right: size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.06,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Get.to(
                              () => ChatScreen(
                                receiverIdForChat: localProfileDetails?.id,
                                userReceiverNameForChat:
                                    localProfileDetails?.name,
                                userReceiverImageForChat:
                                    localProfileDetails?.profileImage,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.chat,
                            color: Colors.red,
                            size: size.width * 0.05,
                          ),
                          label: Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }

  Widget _buildOfferCard(
    String title,
    String description,
    String price,
    String image,
    VoidCallback onTap,
    Size size,
  ) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.25,
            height: size.width * 0.25,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child:
                  (image.isNotEmpty && image.startsWith("http"))
                      ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildShimmerBox(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return _buildShimmerBox(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                          );
                        },
                      )
                      : Image.asset(
                        // ✅ Show local placeholder if URL is empty or invalid
                        'assets/images/bannerPlaceholder.jpg',
                        fit: BoxFit.cover,
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                      ),
              // _buildShimmerBox(
              //   width: size.width * 0.25,
              //   height: size.width * 0.25,
              // ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.width * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(
    String profileName,
    String description,
    String profileImage,
    VoidCallback onTap,
    String reviewScore,
    Size size,
  ) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(fontSize: size.width * 0.035, color: Colors.grey),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              ClipOval(
                child:
                    (profileImage.isNotEmpty && profileImage.startsWith("http"))
                        ? Image.network(
                          profileImage,
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return _buildShimmerBox(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              isCircle: true,
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return _buildShimmerBox(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              isCircle: true,
                            );
                          },
                        )
                        : _buildShimmerBox(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          isCircle: true,
                        ),
              ),
              SizedBox(width: size.width * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: size.width * 0.03,
                        color: Colors.amber,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        reviewScore,
                        style: TextStyle(
                          fontSize: size.width * 0.03,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoader(Size size) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: size.height * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: size.width,
                  height: size.height * 0.35,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.4,
                              height: size.height * 0.025,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Container(
                              width: size.width * 0.15,
                              height: size.height * 0.025,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          width: size.width * 0.3,
                          height: size.height * 0.02,
                          color: Colors.white,
                        ),
                        SizedBox(height: size.height * 0.005),
                        Container(
                          width: size.width * 0.35,
                          height: size.height * 0.02,
                          color: Colors.white,
                        ),
                        SizedBox(height: size.height * 0.015),
                        Container(
                          width: size.width,
                          height: size.height * 0.08,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: size.width * 0.25,
                    height: size.height * 0.025,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.015),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 0.25,
                                height: size.width * 0.25,
                                color: Colors.white,
                              ),
                              SizedBox(width: size.width * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.25,
                                      height: size.height * 0.02,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      width: size.width * 0.6,
                                      height: size.height * 0.015,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      width: size.width * 0.15,
                                      height: size.height * 0.015,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: size.width * 0.2,
                    height: size.height * 0.025,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.015),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.25,
                                    height: size.height * 0.015,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Container(
                                    width: size.width * 0.6,
                                    height: size.height * 0.015,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Container(
                                    width: size.width * 0.15,
                                    height: size.height * 0.015,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + size.height * 0.02,
          left: size.width * 0.04,
          right: size.width * 0.04,
          top: size.height * 0.01,
        ),
        color: Colors.white,
        child: SizedBox(
          width: size.width,
          height: size.height * 0.06,
          child: OutlinedButton.icon(
            onPressed: () {
              // Get.to(
              //   () => ChatScreen(
              //     userIdForChat: ,
              //     userReceiverNameForChat: local,
              //     userReceiverImageForChat: localProfileDetails?.profileImage,
              //   ),
              // );
            },
            icon: Icon(Icons.chat, color: Colors.red, size: size.width * 0.05),
            label: Text(
              'Chat',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.04,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildShimmerBox({
  double width = 100,
  double height = 100,
  bool isCircle = false,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(4),
      ),
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/feature/booking_module/presentation/screens/offer_details_screen_for_tourist.dart';
// import 'package:kobeur/feature/home/controllers/home_controller.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../chat/presentation/screens/chat_screen.dart';

// // ignore: must_be_immutable
// class LocalsProfileForTouristScreen extends StatefulWidget {
//   String localId;
//   LocalsProfileForTouristScreen({super.key, required this.localId});

//   @override
//   State<LocalsProfileForTouristScreen> createState() =>
//       _LocalsProfileForTouristScreenState();
// }

// class _LocalsProfileForTouristScreenState
//     extends State<LocalsProfileForTouristScreen> {
//   late HomeController homeController;

//   @override
//   void initState() {
//     super.initState();
//     homeController = Get.find<HomeController>();
//     // Delay the API call until after the first build
//     print("local id in profile for tourist: ${widget.localId}\n");
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       homeController.getLocalProfile(widget.localId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GetBuilder<HomeController>(
//       builder: (homeController) {
//         final localProfileDetails =
//             homeController.getLocalProfileResponseModel.data;
//         return homeController.isLoading
//             ? _buildShimmerLoader(size)
//             : Scaffold(
//               body: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.only(bottom: 80),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(16),
//                                 bottomRight: Radius.circular(16),
//                               ),
//                               child: FadeInImage.assetNetwork(
//                                 width: double.infinity,
//                                 height: size.height * 0.35,
//                                 fit: BoxFit.cover,
//                                 placeholder:
//                                     'assets/images/profileBlankImage.png',
//                                 image: localProfileDetails?.profileImage ?? '',
//                                 imageErrorBuilder: (
//                                   context,
//                                   error,
//                                   stackTrace,
//                                 ) {
//                                   return Image.asset(
//                                     'assets/images/profileBlankImage.png',
//                                     width: double.infinity,
//                                     height: size.height * 0.35,
//                                     fit: BoxFit.cover,
//                                   );
//                                 },
//                               ),
//                             ),

//                             Positioned(
//                               top: size.height * 0.07,
//                               left: size.width * 0.07,
//                               child: InkWell(
//                                 onTap: () => Navigator.pop(context),
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   child: Icon(
//                                     Icons.arrow_back,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Info Card
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 16),
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 5),
//                               ),
//                             ],
//                           ),
//                           transform: Matrix4.translationValues(0, -45, 0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   "${localProfileDetails?.name}"
//                                       .text20Black700(),
//                                   Spacer(),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 4,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Color(0xffFF3951),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           size: 14,
//                                           color: Colors.white,
//                                         ),
//                                         SizedBox(width: 4),
//                                         Text(
//                                           '4.8',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontFamily: 'Poppins',
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.location_on_outlined,
//                                     size: 26,
//                                     color: Color(0xff666666),
//                                   ),
//                                   SizedBox(width: 4),
//                                   '${localProfileDetails?.country}'
//                                       .text16Grey500(),
//                                 ],
//                               ),
//                               SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.language,
//                                     size: 22,
//                                     color: Color(0xff666666),
//                                   ),
//                                   SizedBox(width: 4),
//                                   Row(
//                                     children:
//                                         localProfileDetails?.languages != null
//                                             ? List.generate(
//                                               localProfileDetails!
//                                                   .languages!
//                                                   .length,
//                                               (index) => Row(
//                                                 children: [
//                                                   Text(
//                                                     localProfileDetails
//                                                         .languages![index],
//                                                   ),
//                                                   if (index !=
//                                                       localProfileDetails
//                                                               .languages!
//                                                               .length -
//                                                           1)
//                                                     Text(", "),
//                                                 ],
//                                               ),
//                                             )
//                                             : [Text('No languages')],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 12),
//                               '${localProfileDetails?.about}'.text14Grey(),
//                             ],
//                           ),
//                         ),

//                         // Offer
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               'Offer'.text20Black700(),

//                               SizedBox(height: 16),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children:
//                                     localProfileDetails?.offers != null &&
//                                             localProfileDetails!
//                                                 .offers!
//                                                 .isNotEmpty
//                                         ? localProfileDetails.offers!.
//                                         // take(2).
//                                         map((offer) {
//                                           return Padding(
//                                             padding: const EdgeInsets.only(
//                                               bottom: 12,
//                                             ),
//                                             child: _buildOfferCard(
//                                               offer.title ??
//                                                   "No Title", // title from API
//                                               offer.description ??
//                                                   "No Description", // description
//                                               "\$${offer.pricePerPerson}", // price
//                                               (offer.photos != null &&
//                                                       offer.photos!.isNotEmpty)
//                                                   ? offer
//                                                       .photos![0] // image from API
//                                                   : "assets/icons/spa.png", // fallback asset
//                                               () {
//                                                 Get.to(
//                                                   () =>
//                                                       OfferDetailsScreenForTouristScreen(
//                                                         localID:
//                                                             localProfileDetails
//                                                                 .id ??
//                                                             "",
//                                                         offerId:
//                                                             offer.sId ?? "",
//                                                       ),
//                                                 ); // tap action
//                                               },
//                                             ),
//                                           );
//                                         }).toList()
//                                         : [
//                                           Center(
//                                             child: Text("No offers available"),
//                                           ),
//                                         ],
//                               ),
//                               SizedBox(height: 24),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Reviews',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'See All',
//                                     style: TextStyle(
//                                       color: Colors.red,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 16),
//                               Column(
//                                 children:
//                                     (localProfileDetails?.rating?.reviews !=
//                                                 null &&
//                                             localProfileDetails!
//                                                 .rating!
//                                                 .reviews!
//                                                 .isNotEmpty)
//                                         ? localProfileDetails.rating!.reviews!.map((
//                                           review,
//                                         ) {
//                                           return Padding(
//                                             padding: const EdgeInsets.only(
//                                               bottom: 12,
//                                             ),
//                                             child: _buildReviewItem(
//                                               review.reviewer?.name ??
//                                                   "Anonymous",
//                                               review.comment ?? "",
//                                               review.reviewer?.profileImage ??
//                                                   "assets/images/profileBlankImage.png",
//                                               () {},
//                                               review.rating?.toStringAsFixed(
//                                                     1,
//                                                   ) ??
//                                                   "0.0",
//                                             ),
//                                           );
//                                         }).toList()
//                                         : [
//                                           Text(
//                                             'No reviews available',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                               ),

//                               // _buildReviewItem(profileName, description, profileImage, onTap, reviewScore),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Bottom Chat Button
//                   // Positioned(
//                   //   bottom: 0,
//                   //   left: 0,
//                   //   right: 0,
//                   //   child: Container(
//                   //     padding: EdgeInsets.only(
//                   //       top: 8,
//                   //       bottom: 32,
//                   //       left: 16,
//                   //       right: 16,
//                   //     ),
//                   //     decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       border: Border(
//                   //         top: BorderSide(color: Colors.grey.shade200),
//                   //       ),
//                   //     ),
//                   //     child: SizedBox(
//                   //       width: double.infinity,
//                   //       height: 48,
//                   //       child: OutlinedButton.icon(
//                   //         onPressed:
//                   //             () => Navigator.pushNamed(context, '/chat'),
//                   //         icon: Icon(Icons.chat, color: Colors.red),
//                   //         label: Text(
//                   //           'Chat',
//                   //           style: TextStyle(
//                   //             color: Colors.red,
//                   //             fontWeight: FontWeight.w600,
//                   //             fontSize: 16,
//                   //           ),
//                   //         ),
//                   //         style: OutlinedButton.styleFrom(
//                   //           side: BorderSide(color: Colors.red),
//                   //           shape: RoundedRectangleBorder(
//                   //             borderRadius: BorderRadius.circular(8),
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               bottomNavigationBar: Container(
//                 padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).padding.bottom,
//                   left: 16,
//                   right: 16,
//                   top: 8,
//                 ),
//                 color: Colors.white,
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: OutlinedButton.icon(
//                     onPressed: () {
//                       Get.to(
//                         () => ChatScreen(
//                           userIdForChat: localProfileDetails?.id,
//                           userReceiverNameForChat: localProfileDetails?.name,
//                           userReceiverImageForChat:
//                               localProfileDetails?.profileImage,
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.chat, color: Colors.red),
//                     label: Text(
//                       'Chat',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: Colors.red),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//       },
//     );
//   }

//   Widget _buildOfferCard(
//     String title,
//     String description,
//     String price,
//     String image,
//     VoidCallback onTap,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           // Fixed size image box
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(4),
//               child:
//                   (image.isNotEmpty && image.startsWith("http"))
//                       ? Image.network(
//                         image,
//                         fit: BoxFit.cover,
//                         width: 100,
//                         height: 100,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return _buildShimmerBox(width: 100, height: 100);
//                         },
//                         errorBuilder: (context, error, stackTrace) {
//                           return _buildShimmerBox(width: 100, height: 100);
//                         },
//                       )
//                       : _buildShimmerBox(width: 100, height: 100),
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   description,
//                   maxLines: 5,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[700]),
//                 ),
//                 SizedBox(height: 4),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       price,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.red,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     InkWell(
//                       onTap: onTap,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           'Book Now',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewItem(
//     String profileName,
//     String description,
//     String profileImage,
//     VoidCallback onTap,
//     String reviewScore,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(description, style: TextStyle(fontSize: 14, color: Colors.grey)),
//           SizedBox(height: 8),
//           Row(
//             children: [
//               ClipOval(
//                 child:
//                     (profileImage.isNotEmpty && profileImage.startsWith("http"))
//                         ? Image.network(
//                           profileImage,
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return _buildShimmerBox(
//                               width: 40,
//                               height: 40,
//                               isCircle: true,
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             return _buildShimmerBox(
//                               width: 40,
//                               height: 40,
//                               isCircle: true,
//                             );
//                           },
//                         )
//                         : _buildShimmerBox(
//                           width: 40,
//                           height: 40,
//                           isCircle: true,
//                         ),
//               ),
//               SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     profileName,
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.star, size: 12, color: Colors.amber),
//                       SizedBox(width: 2),
//                       Text(
//                         reviewScore,
//                         style: TextStyle(fontSize: 12, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Shimmer loader widget
// Widget _buildShimmerLoader(Size size) {
//   return Scaffold(
//     body: SingleChildScrollView(
//       padding: const EdgeInsets.only(bottom: 80),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header image
//           Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Container(
//               width: double.infinity,
//               height: size.height * 0.35,
//               color: Colors.white,
//             ),
//           ),

//           SizedBox(height: 16),

//           // Info Card
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Name & Rating
//                     Row(
//                       children: [
//                         Container(width: 150, height: 20, color: Colors.white),
//                         Spacer(),
//                         Container(width: 50, height: 20, color: Colors.white),
//                       ],
//                     ),
//                     SizedBox(height: 8),

//                     // Location
//                     Container(width: 100, height: 16, color: Colors.white),
//                     SizedBox(height: 4),

//                     // Languages
//                     Container(width: 120, height: 16, color: Colors.white),
//                     SizedBox(height: 12),

//                     // About
//                     Container(
//                       width: double.infinity,
//                       height: 60,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(height: 24),

//           // Offer section title
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Container(width: 100, height: 20, color: Colors.white),
//             ),
//           ),

//           SizedBox(height: 16),

//           // Offer cards shimmer
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: List.generate(2, (index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey.shade300,
//                     highlightColor: Colors.grey.shade100,
//                     child: Container(
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           // Image
//                           Container(
//                             width: 100,
//                             height: 100,
//                             color: Colors.white,
//                           ),
//                           SizedBox(width: 12),
//                           // Text lines
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 16,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 12,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   width: 60,
//                                   height: 14,
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),

//           SizedBox(height: 24),

//           // Reviews section title
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Container(width: 80, height: 20, color: Colors.white),
//             ),
//           ),

//           SizedBox(height: 16),

//           // Reviews shimmer
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: List.generate(2, (index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey.shade300,
//                     highlightColor: Colors.grey.shade100,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Profile image circle
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         // Name + comment
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 100,
//                                 height: 14,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(height: 6),
//                               Container(
//                                 width: double.infinity,
//                                 height: 12,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(height: 6),
//                               Container(
//                                 width: 60,
//                                 height: 12,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),

//           SizedBox(height: 24),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildShimmerBox({
//   double width = 100,
//   double height = 100,
//   bool isCircle = false,
// }) {
//   return Shimmer.fromColors(
//     baseColor: Colors.grey[300]!,
//     highlightColor: Colors.grey[100]!,
//     child: Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
//         borderRadius: isCircle ? null : BorderRadius.circular(4),
//       ),
//     ),
//   );
// }
