import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/feature/profile/presentation/screens/local/locals_profile.dart';
import '../../widgets/favorite_button.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController(text: 'Paris');

  // Categories for horizontal scroll
  final List<Map<String, dynamic>> categories = [
    {'icon': '🍽️', 'label': 'Food', 'color': Colors.orange[100]},
    {'icon': '🎭', 'label': 'Experience', 'color': Colors.purple[100]},
    {'icon': '🚗', 'label': 'Transport', 'color': Colors.blue[100]},
    {'icon': '📷', 'label': 'Photography', 'color': Colors.green[100]},
    {'icon': '🗽', 'label': 'Culture', 'color': Colors.teal[100]},
    {'icon': '🏆', 'label': 'Sport', 'color': Colors.yellow[100]},
  ];

  // Top destinations with flags
  final List<Map<String, dynamic>> destinations = [
    {'id': 1, 'name': 'Paris', 'flag': '🇫🇷', 'country': 'France'},
    {'id': 2, 'name': 'London', 'flag': '🇬🇧', 'country': 'UK'},
    {'id': 3, 'name': 'Tokyo', 'flag': '🇯🇵', 'country': 'Japan'},
    {'id': 4, 'name': 'New York', 'flag': '🇺🇸', 'country': 'USA'},
    {'id': 5, 'name': 'Dubai', 'flag': '🇦🇪', 'country': 'UAE'},
    {'id': 6, 'name': 'Sydney', 'flag': '🇦🇺', 'country': 'Australia'},
  ];

  // final List<Map<String, dynamic>> hotels = [
  //   {
  //     'id': 1,
  //     'name': 'Jasmine Bell',
  //     'location': 'Thailand',
  //     'rating': 4.8,
  //     'price': 120,
  //     'image': '👩‍💼',
  //     'reviews': 'Very Good',
  //   },
  //   {
  //     'id': 2,
  //     'name': 'Jasmine Bell',
  //     'location': 'Thailand',
  //     'rating': 4.8,
  //     'price': 120,
  //     'image': '👨‍💼',
  //     'reviews': 'Very Good',
  //   },
  //   {
  //     'id': 3,
  //     'name': 'Jasmine Bell',
  //     'location': 'Thailand',
  //     'rating': 4.8,
  //     'price': 120,
  //     'image': '👩‍🎨',
  //     'reviews': 'Very Good',
  //   },
  //   {
  //     'id': 4,
  //     'name': 'Jasmine Bell',
  //     'location': 'Thailand',
  //     'rating': 4.8,
  //     'price': 120,
  //     'image': '👨‍🎨',
  //     'reviews': 'Very Good',
  //   },
  // ];

  final List<Map<String, dynamic>> superHatch = [
    {
      'id': 1,
      'name': 'Jasmine Bell',
      'location': 'Tacos at home',
      'rating': 4.8,
      'price': 120,
      'image': 'assets/images/local1.png',
      'reviews': 'Very Good',
      'description':
          "Let’s eat tacos & burritos with locals beers. Always great to share around a BBQ",
      'category': 'photographer',
    },
    {
      'id': 2,
      'name': 'Marcus Chen',
      'location': 'Bali, Indonesia',
      'rating': 4.9,
      'price': 150,
      'image': 'assets/images/local2.png',
      'reviews': 'Excellent',
      'description': 'Wedding photographer',
      'category': 'photographer',
    },
    {
      'id': 3,
      'name': 'Sarah Wilson',
      'location': 'Tacos at home',
      'rating': 4.7,
      'price': 100,
      'image': 'assets/images/local4.png',
      'reviews': 'Very Good',
      'description':
          'Let’s eat tacos & burritos with locals beers. Always great to share around a BBQ',
      'category': 'photographer',
    },
    {
      'id': 4,
      'name': 'David Kumar',
      'location': 'Bali, Indonesia',
      'rating': 4.8,
      'price': 130,
      'image': 'assets/images/local3.png',
      'reviews': 'Very Good',
      'description': 'Travel photographer',
      'category': 'photographer',
    },
    {
      'id': 5,
      'name': 'Emma Rodriguez',
      'location': 'Tacos at home',
      'rating': 4.9,
      'price': 140,
      'image': 'assets/images/local1.png',
      'reviews': 'Excellent',
      'description':
          'Let’s eat tacos & burritos with locals beers. Always great to share around a BBQ',
      'category': 'photographer',
    },
    {
      'id': 6,
      'name': 'John Doe',
      'location': 'Bali, Indonesia',
      'rating': 4.7,
      'price': 110,
      'image': 'assets/images/local2.png',
      'reviews': 'Very Good',
      'description': 'Wedding photographer',
      'category': 'photographer',
    },
    {
      'id': 7,
      'name': 'Jane Smith',
      'location': 'Tacos at home',
      'rating': 4.8,
      'price': 120,
      'image': 'assets/images/local3.png',
      'reviews': 'Excellent',
      'description':
          'Let’s eat tacos & burritos with locals beers. Always great to share around a BBQ',
      'category': 'photographer',
    },
  ];

  void _openSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                SearchScreen(initialSearchQuery: searchController.text),
      ),
    );
  }

  void _onCategoryTapped(Map<String, dynamic> category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SearchScreen(initialSearchQuery: category['label']),
      ),
    );
  }

  void _onDestinationTapped(Map<String, dynamic> destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SearchScreen(initialSearchQuery: destination['name']),
      ),
    );
  }

  void _onHotelTapped(Map<String, dynamic> hotel) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(hotel['name']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${hotel['location']}'),
                Text('Rating: ${hotel['rating']} (${hotel['reviews']})'),
                Text('Price: \$${hotel['price']} per night'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SearchScreen(
                            initialSearchQuery: hotel['location'],
                          ),
                    ),
                  );
                },
                child: Text('Book Now'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: _openSearchScreen,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 12),
                        Text(
                          searchController.text.isEmpty
                              ? 'Paris'
                              : searchController.text,
                          style: TextStyle(
                            color:
                                searchController.text.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Categories Horizontal Scroll
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () => _onCategoryTapped(category),
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: category['color'],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  category['icon'],
                                  style: TextStyle(fontSize: 28),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              category['label'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 24),

              // Top Destination
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top destination',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See more',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: 12),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          final dest = destinations[index];
                          return GestureDetector(
                            onTap: () => _onDestinationTapped(dest),
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    dest['flag'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    dest['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Super Hatch',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See more',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Cards
                    Column(
                      children: List.generate(superHatch.length, (index) {
                        final result = superHatch[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(LocalsProfileScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Image
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.asset(
                                        result['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),

                                  // Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Name & Favorite
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                result['name'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const FavoriteButton(size: 20),
                                          ],
                                        ),
                                        SizedBox(height: 4),

                                        // Image Label + Description
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/takeaway.png',
                                                  height: 40,
                                                  fit: BoxFit.contain,
                                                ),
                                                Text(
                                                  "Takeaway",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    result['location'],
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    result['description'],
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),

                                        // Rating and Price
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 12,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  '${result['rating']}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'from ',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  '${result['price']}€',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  ' / person',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                  ),
                                                ),
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
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // Super Hatch
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Super Hatch',
              //               style: TextStyle(
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => SearchScreen(),
              //                   ),
              //                 );
              //               },
              //               child: Text(
              //                 'See more',
              //                 style: TextStyle(color: Colors.red),
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 12),
              //         Expanded(
              //           child: ListView.separated(
              //             separatorBuilder: (_, __) => SizedBox(height: 16),
              //             padding: EdgeInsets.symmetric(horizontal: 16),
              //             itemCount: superHatch.length,
              //             itemBuilder: (context, index) {
              //               final result = superHatch[index];
              //               return Container(
              //                 // margin: EdgeInsets.only(bottom: 16),
              //                 // padding: EdgeInsets.all(16),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.circular(8),
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.grey.withOpacity(0.1),
              //                       blurRadius: 4,
              //                       offset: Offset(0, 2),
              //                     ),
              //                   ],
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     Container(
              //                       // width: 120,
              //                       height: 120,
              //                       decoration: BoxDecoration(
              //                         color: Colors.grey[100],
              //                         // shape: BoxShape.circle,
              //                         borderRadius: BorderRadius.circular(4),
              //                       ),
              //                       child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(4),
              //                         child: Image.asset(
              //                           result['image'],

              //                           //'assets/images/local1.png',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(width: 12),
              //                     Expanded(
              //                       child: Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Text(
              //                                 result['name'],
              //                                 style: TextStyle(
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: 16,
              //                                   color: Colors.black,
              //                                 ),
              //                               ),
              //                               const FavoriteButton(size: 20),
              //                             ],
              //                           ),

              //                           Row(
              //                             children: [
              //                               Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.center,
              //                                 children: [
              //                                   Image.asset(
              //                                     'assets/images/takeaway.png',
              //                                     height: 40,
              //                                     fit: BoxFit.contain,
              //                                   ),
              //                                   Text(
              //                                     "Takeaway",
              //                                     style: TextStyle(
              //                                       color: Colors.black,
              //                                       fontSize: 10,
              //                                       fontWeight: FontWeight.w400,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               const SizedBox(width: 8),
              //                               Expanded(
              //                                 child: Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       result['location'],
              //                                       style: TextStyle(
              //                                         color: Colors.red,
              //                                         fontWeight: FontWeight.w600,
              //                                         fontSize: 14,
              //                                       ),
              //                                     ),
              //                                     Text(
              //                                       result['description'],
              //                                       maxLines: 5,
              //                                       //overflow: TextOverflow.ellipsis,
              //                                       style: TextStyle(
              //                                         color: Colors.grey[600],
              //                                         fontSize: 10,
              //                                         fontWeight: FontWeight.w400,
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),

              //                           Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   Icon(
              //                                     Icons.star,
              //                                     color: Colors.amber,
              //                                     size: 12,
              //                                   ),
              //                                   SizedBox(width: 4),
              //                                   Text(
              //                                     '${result['rating']}',
              //                                     style: TextStyle(fontSize: 12),
              //                                   ),
              //                                 ],
              //                               ),

              //                               Row(
              //                                 children: [
              //                                   Text(
              //                                     'from ',
              //                                     style: TextStyle(
              //                                       color: Colors.red,
              //                                       fontWeight: FontWeight.w600,
              //                                       fontSize: 12,
              //                                     ),
              //                                   ),
              //                                   Text(
              //                                     '${result['price']}\€',
              //                                     style: TextStyle(
              //                                       color: Colors.red,
              //                                       fontWeight: FontWeight.w600,
              //                                       fontSize: 18,
              //                                     ),
              //                                   ),
              //                                   Text(
              //                                     '/ ',
              //                                     style: TextStyle(
              //                                       color: Colors.black87,
              //                                       fontSize: 18,
              //                                     ),
              //                                   ),
              //                                   Text(
              //                                     'person',
              //                                     style: TextStyle(
              //                                       color: Colors.black87,
              //                                       fontSize: 12,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),

              //                               // Text(
              //                               //   '(${result['reviews']})',
              //                               //   style: TextStyle(
              //                               //     color: Colors.grey,
              //                               //     fontSize: 12,
              //                               //   ),
              //                               // ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [],
              //                     ),
              //                   ],
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
