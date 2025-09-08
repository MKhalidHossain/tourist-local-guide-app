import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/booking_module/presentation/screens/booking_confarm.dart';

class BookingOfferSummaryScreen extends StatefulWidget {
  @override
  _BookingOfferSummaryScreenState createState() =>
      _BookingOfferSummaryScreenState();
}

class _BookingOfferSummaryScreenState extends State<BookingOfferSummaryScreen> {
  String selectedPaymentMethod = 'card';
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  backgroundImage: AssetImage('assets/images/local3.png'),
                  // NetworkImage(
                  //   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
                  // ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Jerome Bell'.text18Black(),

                    'China'.text12DarkGrey(),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

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
                        Container(
                          width: 110,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(
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
                              'Nanchan Temple'.text14Black600(),
                              'City Tour'.text14Grey(),
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
                                      '5(4.8)'.text12Black(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      '\$30'.text16LightRed(),
                                      '/hour'.text12Black(),
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
                  _buildSummaryRow('Service', 'Restaurant'),
                  _buildSummaryRow('Schedule', '9:00 AM, 11/08/25'),
                  _buildSummaryRow('Participants', '04 People'),
                  _buildSummaryRow('Price per person', '\$30.00'),
                  Divider(height: 16),
                  _buildSummaryRow('Total', '\$120.00', isTotal: true),
                  SizedBox(height: 18),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Promotion Code Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Promotion Code',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _promoController,
                      decoration: InputDecoration(
                        hintText: 'Write promotion code here...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color:
                  isTotal
                      ? Colors.red
                      : (isService ? Colors.blue : Colors.black),
              decoration: isService ? TextDecoration.underline : null,
            ),
          ),
        ],
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
