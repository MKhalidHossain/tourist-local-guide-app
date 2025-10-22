import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kobeur/core/widgets/normal_custom_button.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import '../../../../../core/common/button/button_widget.dart';
import '../../../../offer/presentation/screens/common/category_selection_screen.dart';
import '../../../../offer/presentation/screens/local/offer_details_screen_for_local.dart';

class MyOffersListScreen extends StatelessWidget {
  final String localId;

  MyOffersListScreen({super.key, required this.localId});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    // Fetch offers
    homeController.getAllOwnOffer();

    return GetBuilder<HomeController>(
      builder: (controller) {
        final myOfferData = controller.getAllOwnOfferResponseModel.data;

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              'My Offers',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: BackButton(color: Colors.black),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (controller.isLoading)
                  ...List.generate(4, (_) => _buildShimmerCard(size))
                else if (myOfferData != null && myOfferData.isNotEmpty)
                  for (var offer in myOfferData)
                    _buildOfferCard(
                      offer.title,
                      offer.description,
                      offer.photos.isNotEmpty ? offer.photos.first : '',
                      () {
                        Get.to(
                          OfferDetailsForLocalScreen(
                            localID: localId,
                            offerId: offer.id,
                          ),
                        );
                      },
                      size,
                    ),
                const SizedBox(height: 16),
                DottedBorder(
                  color: const Color(0xff666666),
                  strokeWidth: 2,
                  dashPattern: [8, 8],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Get.to(CategorySelectionScreen());
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.grey[600], size: 28),
                          const SizedBox(width: 8),
                          const Text(
                            'Add New Service',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildOfferCard(
  String title,
  String description,
  String image,
  VoidCallback onTap,
  Size size,
) {
  final imageSize = size.width * 0.25;
  final buttonWidth = size.width * 0.25;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.02),
      ),
      child: Row(
        children: [
          Container(
            height: imageSize,
            width: imageSize,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.02),
              child:
                  image.isNotEmpty && image.startsWith("http")
                      ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(color: Colors.white),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/profileBlankImage.png',
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
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.045,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  description,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NormalCustomButton(
                      showIcon: false,
                      fontSize: size.width * 0.04,
                      height: size.height * 0.045,
                      weight: buttonWidth,
                      text: "Edit",
                      onPressed: onTap,
                    ),
                    SecondaryButton(
                      width: buttonWidth,
                      height: size.height * 0.045,
                      text: 'Delete',
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget _buildOfferCard(
//   String title,
//   String description,
//   // String price,
//   String image,
//   VoidCallback onTap,
//   Size size,
// ) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 120,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               // shape: BoxShape.circle,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(4),
//               child:
//                   image.startsWith("http")
//                       ? Image.network(
//                         image,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             'assets/images/profileBlankImage.png',
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       )
//                       : Image.asset(
//                         image.isNotEmpty
//                             ? image
//                             : 'assets/images/profileBlankImage.png',
//                         fit: BoxFit.cover,
//                       ),
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
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     NormalCustomButton(
//                       showIcon: false,
//                       fontSize: 16,
//                       height: 30,
//                       weight: size.width*0.25,
//                       text: "Edit", onPressed: (){}),

//                     SecondaryButton(
//                       width: size.width*0.25,
//                       height: 30,
//                       text: 'Delete',
//                       onPressed: (){

//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 8),
//         ],
//       ),
//     ),
//   );
// }

Widget _buildShimmerCard(Size size) {
  final imageSize = size.width * 0.25;
  final buttonWidth = size.width * 0.25;

  return Container(
    margin: EdgeInsets.only(bottom: size.height * 0.02),
    padding: EdgeInsets.all(size.width * 0.03),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(size.width * 0.02),
    ),
    child: Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: imageSize,
            width: imageSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: size.height * 0.02,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: size.height * 0.015,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: size.height * 0.045,
                      width: buttonWidth,
                      color: Colors.white,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: size.height * 0.045,
                      width: buttonWidth,
                      color: Colors.white,
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
