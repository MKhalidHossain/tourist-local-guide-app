import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
import 'package:kobeur/feature/offer/domain/model/service_data.dart';
import '../../../domain/model/offers_item.dart';
import '../../details_offer_local.dart';

class OfferPricingScreen extends StatefulWidget {
  final OfferItem offer;
  const OfferPricingScreen({super.key, required this.offer});

  @override
  State<OfferPricingScreen> createState() => _OfferPricingScreenState();
}

class _OfferPricingScreenState extends State<OfferPricingScreen> {
  int guestCount = 2;
  int pricePerPerson = 12;
  int maxParticipants = 5;
  ServiceData serviceData = ServiceData();

  void _changeGuestCountPrice(int change) {
    setState(() {
      pricePerPerson = (pricePerPerson + change).clamp(1, 1000);
    });
  }

  void _changeGuestCountParticipants(int change) {
    setState(() {
      maxParticipants = (maxParticipants + change).clamp(1, 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // void _changeGuestCount(int change) {
    //   setState(() {
    //     guestCount = (guestCount + change).clamp(1, 20);
    //   });
    // }

    serviceData.selectedOfferType = widget.offer.title;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(color: Colors.black),
                      widget.offer.title.text22Black700(),
                      SizedBox(width: 50),
                    ],
                  ),
                  SizedBox(height: 36),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            widget.offer.imagePath,
                            fit: BoxFit.cover,
                            height: 70,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.offer.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.offer.description,
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
                  const SizedBox(height: 24),
                  // Guest Count
                  Text(
                    ' Price per person',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _changeGuestCountPrice(-1),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffFF3951),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/minusSquare.png',
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text(
                            '\$' + '$pricePerPerson',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _changeGuestCountPrice(1),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffFF3951),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/plusSquare.png',
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 36),
                  // SizedBox(height: 36),

                  // Guest Count
                  Text(
                    ' Maximum number of participants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _changeGuestCountParticipants(-1),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffFF3951),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/minusSquare.png',
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text(
                            " ${maxParticipants.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _changeGuestCountParticipants(1),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffFF3951),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/plusSquare.png',
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 36),
                ],
              ),
              Container(
                child: WideCustomButton(
                  text: 'Next',
                  onPressed: () {
                    serviceData.selectedPrcing = pricePerPerson.toString();
                    serviceData.selectedparticipants =
                        maxParticipants.toString();
                    serviceData.printData();
                    Get.to(DetailsOfferLocal());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
