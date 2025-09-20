import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/app_scaffold.dart';

import '../../../../offer/presentation/screens/category_selection_screen.dart';

class MyServiceScreen extends StatelessWidget {
  const MyServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildOfferCard(
            "No Title", // title from API
            "No Description", // description
            "\${offer}", // price
            "assets/icons/spa.png", // fallback asset
            () {
              // Get.to(
              //   OfferDetailsScreenForTouristScreen(
              //     localID: localProfileDetails.id ?? "",
              //     offerId: offer.sId ?? "",
              //   ),
              // ); // tap action
            },
          ),

          //  SizedBox(height: 16),
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children:
          //                           localProfileDetails?.offers != null &&
          //                                   localProfileDetails!
          //                                       .offers!
          //                                       .isNotEmpty
          //                               ? localProfileDetails.offers!.take(2).map((
          //                                 offer,
          //                               ) {
          //                                 return Padding(
          //                                   padding: const EdgeInsets.only(
          //                                     bottom: 12,
          //                                   ),
          //                                   child: _buildOfferCard(
          //                                     offer.title ??
          //                                         "No Title", // title from API
          //                                     offer.description ??
          //                                         "No Description", // description
          //                                     "\$${offer.pricePerPerson}", // price
          //                                     (offer.photos != null &&
          //                                             offer.photos!.isNotEmpty)
          //                                         ? offer
          //                                             .photos![0] // image from API
          //                                         : "assets/icons/spa.png", // fallback asset
          //                                     () {
          //                                       Get.to(
          //                                         OfferDetailsScreenForTouristScreen(
          //                                           localID:
          //                                               localProfileDetails
          //                                                   .id ??
          //                                               "",
          //                                           offerId: offer.sId ?? "",
          //                                         ),
          //                                       ); // tap action
          //                                     },
          //                                   ),
          //                                 );
          //                               }).toList()
          //                               : [
          //                                 Center(
          //                                   child: Text("No offers available"),
          //                                 ),
          //                               ],
          //                     ),
          const SizedBox(height: 16),
          DottedBorder(
            color: Color(0xff666666),
            strokeWidth: 2,
            dashPattern: [8, 8], // dash length and space
            borderType: BorderType.RRect,
            radius: Radius.circular(8),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(CategorySelectionScreen());
                },
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.grey[600], size: 28),
                    SizedBox(width: 8),
                    'Add New Service'.text16Grey500(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildOfferCard(
  String title,
  String description,
  String price,
  String image,
  VoidCallback onTap,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Container(
          // width: 120,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child:
                image.startsWith("http")
                    ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/profileBlankImage.png',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                    : Image.asset(
                      image.isNotEmpty
                          ? image
                          : 'assets/images/profileBlankImage.png',
                      fit: BoxFit.cover,
                    ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                description,
                maxLines: 5,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  OutlinedButton(onPressed: () {}, child: Text("Delete")),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
      ],
    ),
  );
}
