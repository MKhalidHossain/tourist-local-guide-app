import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/offer/presentation/screens/common/category_selection_screen.dart';

import '../../../../../navigation/bottom_navigationber_screen.dart';

class CreateFirstServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   // backgroundColor: Colors.grey[100],
      //   elevation: 0,
      //   title: Text(
      //     'Create First Service',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              'Create Your First Offer'.text24Black(),

              SizedBox(height: 40),
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
                        'Create First Offer'.text16Grey500(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Get.offAll(() => BottomNavbar(userRole: "Local"));
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   height: 60,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey[300]!, width: 2),
              //     borderRadius: BorderRadius.circular(8),
              //     color: Colors.white,
              //   ),
              //   child: InkWell(
              //     onTap: () {
              //       Get.to(CategorySelectionScreen());
              //     },
              //     borderRadius: BorderRadius.circular(8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.add, color: Colors.grey[600], size: 24),
              //         SizedBox(width: 8),
              //         Text(
              //           'Create First Offer',
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.grey[600],
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
