import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';

import '../../../domain/model/offers_item.dart';
import '../../../domain/model/service_data.dart';
import '../offer_pricing_screen.dart';

class CultureOffersScreen extends StatefulWidget {
  const CultureOffersScreen({super.key});

  @override
  State<CultureOffersScreen> createState() => _CultureOffersScreenState();
}

class _CultureOffersScreenState extends State<CultureOffersScreen> {
  String? selectedOffer;
  String? selectedCultureNameforStore;
  ServiceData serviceData = ServiceData();

  final List<OfferItem> offers = [
    OfferItem(
      'Museums',
      'Lead museum tours, sharing essential insights with tourists',

      "assets/icons/museums.png",
      'museums',
    ),
    OfferItem(
      'Monuments',
      'Lead tourists on tours to your city’s best landmarks',
      'assets/icons/monuments.png',
      'monuments',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.black),
                'What is your Offer?'.text22Black700(),
                SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  final isSelected = selectedOffer == offer.value;

                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOffer = offer.value;
                          selectedCultureNameforStore = offer.title;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.red : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.red.withOpacity(0.1)
                                        : Colors.grey[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image.asset(
                                offer.imagePath,
                                fit: BoxFit.cover,
                                // color: Colors.white,
                                height: 70,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isSelected
                                              ? Colors.red
                                              : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    offer.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.info_outline,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      selectedOffer != null
                          ? () {
                            serviceData.selectedOfferType =
                                selectedCultureNameforStore;
                            serviceData.printData();
                            Get.to(
                              OfferPricingScreen(
                                offer: offers.firstWhere(
                                  (offer) => offer.value == selectedOffer!,
                                ),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
