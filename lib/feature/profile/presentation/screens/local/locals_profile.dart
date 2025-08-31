import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/booking_tourist/presentation/screens/offer_screen.dart';

class LocalsProfileScreen extends StatelessWidget {
  const LocalsProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header with back button
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image:
                          // NetworkImage(
                          //   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
                          // ),
                          AssetImage('assets/images/localsProfileHederBG.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.07,
                      left: size.width * 0.07,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),

                // Info Card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  transform: Matrix4.translationValues(0, -45, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          'Jerome Bell'.text20Black700(),
                          // Text(
                          //   'Jerome Bell',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffFF3951),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 26,
                            color: Color(0xff666666),
                          ),
                          SizedBox(width: 4),
                          'China'.text16Grey500(),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            size: 22,
                            color: Color(0xff666666),
                          ),
                          SizedBox(width: 4),
                          'English, French'.text16Grey500(),
                        ],
                      ),
                      SizedBox(height: 12),
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam quis enim at risus laoreet dignissim. Praesent commodo venenatis pharetra.'
                          .text14Grey(),
                      // Text(
                      //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam quis enim at risus laoreet dignissim. Praesent commodo venenatis pharetra.',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey[700],
                      //     height: 1.4,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Offer
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Offer'.text20Black700(),

                      SizedBox(height: 16),
                      _buildOfferCard(
                        'Spa',
                        'Give a massage, rent a sauna or hammam',

                        '\$12',
                        'assets/icons/spa.png',
                        () {
                          Get.to(OfferScreen());
                        },
                      ),
                      SizedBox(height: 12),
                      _buildOfferCard(
                        'Restaurant',
                        'Share restaurant with tourist and have a good time .Share restaurant with tourist and have a good time',
                        '\$12',

                        'assets/icons/restaurant.png',
                        () {
                          Get.to(OfferScreen());
                        },
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'See All',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildReviewItem(),
                      SizedBox(height: 12),
                      _buildReviewItem(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Chat Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 32, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/chat'),
                  icon: Icon(Icons.chat, color: Colors.red),
                  label: Text(
                    'Chat',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
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
              child: Image.asset(
                image,
                //'assets/images/local1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // CircleAvatar(
          //   radius: 22,
          //   backgroundImage: AssetImage(
          //     'assets/images/avatar.png',
          //   ), // replace with proper asset
          // ),
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
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
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

  Widget _buildReviewItem() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alex was an amazing guide! Showed us places we would never have found on our own.',
            style: TextStyle(fontSize: 13, color: Colors.grey[800]),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jerome Bell',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(width: 8),
                      Icon(Icons.star, size: 12, color: Colors.amber),
                      SizedBox(width: 2),
                      Text('5.0', style: TextStyle(fontSize: 12)),
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
}

// import 'package:flutter/material.dart';

// class LocalsProfileScreen extends StatelessWidget {
//   const LocalsProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Locals Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Profile Header
//           Container(
//             width: double.infinity,
//             height: 300,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
//                 ),
//               ),
//             ),
//           ),

//           // Profile Info Card
//           Transform.translate(
//             offset: Offset(0, -30),
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Jerome Bell',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Spacer(),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           'CA',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, size: 16, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text('China', style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.language, size: 16, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text(
//                         'English, French',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Offers Section
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Offer',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),

//                   // Spa Offer
//                   _buildOfferCard(
//                     context,
//                     'Spa',
//                     'Give a massage, rent a sauna or hammam',
//                     '\$12',
//                     'Book Now',
//                   ),
//                   SizedBox(height: 12),

//                   // Restaurant Offer
//                   _buildOfferCard(
//                     context,
//                     'Restaurant',
//                     'A good restaurant with tourist and have good food',
//                     '\$12',
//                     'Book Now',
//                   ),
//                   SizedBox(height: 20),

//                   // Reviews Section
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Reviews',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'See All',
//                         style: TextStyle(color: Colors.red, fontSize: 14),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),

//                   // Review Items
//                   _buildReviewItem(
//                     'Alex was an amazing guide! Showed us places we would never have found on our own.',
//                     'Jerome Bell',
//                     5.0,
//                   ),
//                   SizedBox(height: 12),
//                   _buildReviewItem(
//                     'Alex was an amazing guide! Showed us places we would never have found on our own.',
//                     'Jerome Bell',
//                     5.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Chat Button
//           Container(
//             padding: EdgeInsets.all(20),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: OutlinedButton(
//                 onPressed: () => Navigator.pushNamed(context, '/chat'),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(color: Colors.red),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.chat_bubble_outline, color: Colors.red),
//                     SizedBox(width: 8),
//                     Text(
//                       'Chat',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOfferCard(
//     BuildContext context,
//     String title,
//     String description,
//     String price,
//     String buttonText,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Icon(
//               title == 'Spa' ? Icons.spa : Icons.restaurant,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   price,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               buttonText,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewItem(String review, String name, double rating) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           review,
//           style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
//         ),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 12,
//               backgroundImage: NetworkImage(
//                 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
//               ),
//             ),
//             SizedBox(width: 8),
//             Text(
//               name,
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(width: 8),
//             Row(
//               children: [
//                 Icon(Icons.star, size: 12, color: Colors.amber),
//                 SizedBox(width: 2),
//                 Text(rating.toString(), style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
