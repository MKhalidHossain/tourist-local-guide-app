import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/booking_module/presentation/screens/booking_confarm.dart';
import 'package:shimmer/shimmer.dart';

import '../../../home/domain/tourist/get_offer_details_response_model.dart';

class BookingOfferSummaryScreen extends StatefulWidget {
  final Offer offer;
  final Local local;

  const BookingOfferSummaryScreen({
    Key? key,
    required this.offer,
    required this.local,
  }) : super(key: key);
  @override
  _BookingOfferSummaryScreenState createState() =>
      _BookingOfferSummaryScreenState();
}

class _BookingOfferSummaryScreenState extends State<BookingOfferSummaryScreen> {
  String selectedPaymentMethod = 'card';
  // final TextEditingController _promoController = TextEditingController();
  String formattedDate = '';

  String formatDateTime(List<Availability>? availability) {
    if (availability == null || availability.isEmpty) return "";

    final item = availability.first;
    final rawDate = DateTime.parse(item.date!); // item.date is String
    final times = (item.timeSlots ?? []).map((t) => t.toString()).join(", ");
    final formattedDate = DateFormat("MM/dd/yy").format(rawDate);

    return "$times, $formattedDate";
  }

  // 👉 "10:00 AM, 11:00 AM, 09/17/25"

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final String totalPrice =
        "${(widget.offer.pricePerPerson ?? 0) * (widget.offer.maxParticipants ?? 1)}";
    final fomatedDateForShow = formatDateTime(widget.offer.availability);
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            // Custom Header
            Row(
              children: [
                BackButton(onPressed: () => Navigator.pop(context)),
                SizedBox(width: 12),
                CircleAvatar(
                  radius: 26,
                  backgroundImage:
                      (widget.local.profileImage != null &&
                              widget.local.profileImage!.isNotEmpty)
                          ? NetworkImage(widget.local.profileImage!)
                          : const AssetImage(
                                'assets/images/profileBlankImage.png',
                              )
                              as ImageProvider,
                ),

                // CircleAvatar(
                //   radius: 26,
                //   backgroundImage:
                //   // AssetImage('assets/images/local3.png'),
                //   NetworkImage('${widget.local.profileImage}'),
                // ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${widget.local.firstName} ${widget.local.lastName}"
                        .text18Black(),

                    "${widget.local.location} ".text12DarkGrey(),
                  ],
                ),
              ],
            ),

            // Offer Section
            const SizedBox(height: 20),
            'Offer'.text20Black700(),
            //const SizedBox(height: 12),
            Container(
              width: double.infinity,
              //padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.offer.photos?.first ?? "",
                            width: 110,
                            height: 80,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 110,
                                  height: 80,
                                  color: Colors.white,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/nanchanTemple.png", // fallback image
                                width: 110,
                                height: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              '${widget.offer.title}'.text14Black600(),
                              '${widget.offer.offerType}'.text14Grey(),
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
                                      '${widget.local.averageRating?.toStringAsFixed(1)}'
                                          .text12Black(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      '\$${widget.offer.pricePerPerson?.toStringAsFixed(2)}'
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
            SizedBox(height: 20),

            // Summary
            'Summary'.text20Black700(),

            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Service', '${widget.offer.category}'),
                  _buildSummaryRow('Schedule', '${fomatedDateForShow}'),
                  _buildSummaryRow(
                    'Participants',
                    '${widget.offer.maxParticipants}',
                  ),
                  _buildSummaryRow(
                    'Price per person',
                    '\$${widget.offer.pricePerPerson}',
                  ),
                  Divider(height: 16),
                  _buildSummaryRow('Total', '\$ ${totalPrice}', isTotal: true),
                  SizedBox(height: 18),
                ],
              ),
            ),

            // ************************************************ In Future If Need Uncomment Code and Connect to api  ************************************************

            // SizedBox(height: 8),

            // Promotion Code Section
            // Container(
            //   width: double.infinity,
            //   color: Colors.white,
            //   padding: EdgeInsets.all(20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Promotion Code',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //       ),
            //       SizedBox(height: 12),
            //       Container(
            //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: Colors.grey[100],
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: TextField(
            //           controller: _promoController,
            //           decoration: InputDecoration(
            //             hintText: 'Write promotion code here...',
            //             hintStyle: TextStyle(
            //               color: Colors.grey[500],
            //               fontSize: 14,
            //             ),
            //             border: InputBorder.none,
            //             contentPadding: EdgeInsets.zero,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 8),

            // Payment Methods Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildPaymentOption(
                    'Pay With Card',
                    Icons.credit_card,
                    'card',
                  ),
                  SizedBox(height: 12),
                  _buildPaymentOption('Pay With Apple', Icons.apple, 'apple'),
                  SizedBox(height: 12),
                  _buildPaymentOption(
                    'Pay With Google',
                    Icons.g_mobiledata,
                    'google',
                    subtitle: 'Final Copy',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 8, bottom: 36, left: 20, right: 20),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Get.to(BookingConfirmedScreen());
            },
            // onPressed: () => Navigator.pushNamed(context, '/payment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isService = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [label.text16Grey500(), value.text16Black500()],
      ),
    );
  }

  Widget _buildPaymentOption(
    String title,
    IconData icon,
    String value, {
    String? subtitle,
  }) {
    bool isCurrentlySelected = selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
        print('Selected payment method: $selectedPaymentMethod'); // Debug print
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isCurrentlySelected ? Colors.red : Colors.grey[300]!,
            width: isCurrentlySelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCurrentlySelected ? Colors.red : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child:
                  isCurrentlySelected
                      ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      )
                      : null,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                ],
              ),
            ),
            if (value == 'card')
              Icon(Icons.credit_card, size: 24, color: Colors.blue)
            else if (value == 'apple')
              Icon(Icons.apple, size: 24, color: Colors.black)
            else if (value == 'google')
              Text(
                'G Pay',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String getSelectedPaymentMethod() {
    return selectedPaymentMethod;
  }

  void processPayment() {
    String paymentMethod = getSelectedPaymentMethod();
    print('Processing payment with: $paymentMethod');

    // You can use this value for payment processing
    switch (paymentMethod) {
      case 'card':
        // Handle card payment
        Navigator.pushNamed(context, '/payment');
        break;
      case 'apple':
        // Handle Apple Pay
        // Add Apple Pay integration here
        break;
      case 'google':
        // Handle Google Pay
        // Add Google Pay integration here
        break;
    }
  }
}
