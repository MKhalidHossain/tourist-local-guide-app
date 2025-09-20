import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/offer/domain/model/service_data.dart';

import 'offers_items_for_all_category/culture_offers_screen.dart';
import 'offers_items_for_all_category/food_offers_screen.dart';
import 'offers_items_for_all_category/experience_offers_screen.dart';
import 'offers_items_for_all_category/photography_offer_screen.dart';
import 'offers_items_for_all_category/sport_offers_screen.dart';
import 'offers_items_for_all_category/transport_offers_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  String? selectedCategory;
  String? selectedCategoryNameforStore;
  ServiceData serviceData = ServiceData();

  final List<CategoryItem> categories = [
    CategoryItem('Food', 'assets/icons/food.png', 'food'),
    CategoryItem('Experience', 'assets/icons/experience.png', 'experience'),
    CategoryItem('Transport', 'assets/icons/transport.png', 'transport'),
    CategoryItem('Photography', 'assets/icons/photography.png', 'photography'),
    CategoryItem('Sport', 'assets/icons/sport.png', 'sport'),
    CategoryItem('Culture', 'assets/icons/culture.png', 'culture'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   //backgroundColor: Colors.grey[100],
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text(
      //     'Category',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: 'What is your Category?'.text24Black(),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category.value;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category.value;
                          selectedCategoryNameforStore = category.name;
                        });
                        print(
                          '\n\n\n\n\n\nSelected Category in button : $selectedCategory\n\n\n\n\n\n\n',
                        );
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? Color(0xffFF3951)
                                    : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Color(0xffFF3951).withOpacity(0.1)
                                        : Colors.grey[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Image.asset(
                                category.imagePath,
                                fit: BoxFit.cover,
                                // color: Colors.white,
                                height: 80,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.red : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      selectedCategory != null
                          ? () {
                            print(
                              '\n\n\n\n\n\nSelected Category: $selectedCategoryNameforStore\n\n\n\n\n\n\n',
                            );
                            serviceData.selectedCategory =
                                selectedCategoryNameforStore;
                            serviceData.printData();

                            switch (selectedCategory) {
                              case 'food':
                                Get.to(FoodOffersScreen());
                                break;
                              case 'experience':
                                Get.to(ExperienceOffersScreen());
                                break;
                              case 'transport':
                                Get.to(TransportOffersScreen());
                                break;
                              case 'photography':
                                Get.to(PhotographyOffersScreen());
                                break;
                              case 'sport':
                                Get.to(SportOffersScreen());
                                break;
                              case 'culture':
                                Get.to(CultureOffersScreen());
                                break;
                            }
                          }
                          : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF3951),
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

class CategoryItem {
  final String name;
  final String imagePath;
  final String value;

  CategoryItem(this.name, this.imagePath, this.value);
}
