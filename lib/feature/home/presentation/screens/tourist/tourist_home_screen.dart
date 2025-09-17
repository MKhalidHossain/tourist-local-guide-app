import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:kobeur/feature/profile/presentation/screens/local/locals_profile_for_tourist_show.dart';
import '../../widgets/favorite_button.dart';
import 'search_screen.dart';
import 'package:shimmer/shimmer.dart';

class TouristHomeScreen extends StatefulWidget {
  @override
  _TouristHomeScreenState createState() => _TouristHomeScreenState();
}

class _TouristHomeScreenState extends State<TouristHomeScreen> {
  TextEditingController searchController = TextEditingController();

  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    homeController.getSuperHatch();
  }

  final List<Map<String, dynamic>> categories = [
    {
      'imagePath': 'assets/icons/food.png',
      'label': 'Food',
      'color': Colors.white,
    },
    {
      'imagePath': 'assets/icons/experience.png',
      'label': 'Experience',
      'color': Colors.white,
    },
    {
      'imagePath': 'assets/icons/transport.png',
      'label': 'Transport',
      'color': Colors.white,
    },
    {
      'imagePath': 'assets/icons/photo.png',
      'label': 'Photography',
      'color': Colors.white,
    },
    {
      'imagePath': 'assets/icons/culture.png',
      'label': 'Culture',
      'color': Colors.white,
    },
    {
      'imagePath': 'assets/icons/sport.png',
      'label': 'Sport',
      'color': Colors.white,
    },
  ];

  // Top destinations with flags
  final List<Map<String, dynamic>> destinations = [
    {'id': 1, 'name': 'Paris', 'flag': '🇫🇷', 'country': 'France'},
    {'id': 2, 'name': 'London', 'flag': '🇬🇧', 'country': 'UK'},
    {'id': 3, 'name': 'Tokyo', 'flag': '🇯🇵', 'country': 'Japan'},
    {'id': 4, 'name': 'New York', 'flag': '🇺🇸', 'country': 'USA'},
  ];

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
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      builder: (homeController) {
        final superHatchData = homeController.getSuperHatchResponseModel?.data;
        return homeController.isLoading
            ? _buildFullScreenShimmer(size)
            : Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: _openSearchScreen,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
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
                                      ? 'Explore like a local'
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
                      const SizedBox(height: 8),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () => _onCategoryTapped(category),
                              child: Container(
                                width: size.width * 0.157,
                                margin: EdgeInsets.only(
                                  right: size.width * 0.01,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: size.width * 0.155,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: category['color'],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          category['imagePath'],
                                          width: size.width * 0.15,
                                          height: size.width * 0.15,
                                          fit: BoxFit.cover,
                                        ),
                                        // Text(
                                        //   category['icon'],
                                        //   style: TextStyle(fontSize: 28),
                                        // ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      category['label'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "poppins",
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
                                "Top destination".text20Black700(),

                                const SizedBox(width: 8),
                              ],
                            ),
                            SizedBox(height: 12),
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
                                        horizontal: 6,
                                        vertical: 0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                        ),
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
                                "Super Hatch".text20Black700(),

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
                            //                             final superHatchData = homeController.getSuperHatchResponseModel?.data;

                            // if (superHatchData == null || superHatchData.isEmpty) {
                            //   return Center(
                            //     child: Text("No data available"),
                            //   );
                            // }       /// 👇 CHANGE START: shimmer / empty / real data

                            /// 👇 CHANGE START: shimmer / empty / real data
                            if (superHatchData == null)
                              _buildShimmerLoader() // show shimmer while loading
                            else if (superHatchData.isEmpty)
                              Center(child: Text("No data available"))
                            else
                              Column(
                                children: List.generate(superHatchData.length, (
                                  index,
                                ) {
                                  final result = superHatchData[index];
                                  return _buildSuperHatchCard(result);
                                }),
                              ),

                            /// 👆 CHANGE END
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }

  Widget _buildFullScreenShimmer(Size size) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔎 Search Bar
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 20),

                  // 📂 Categories
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder:
                          (_, __) => Container(
                            width: size.width * 0.18,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // 🌍 Top Destination placeholders
                  Row(
                    children: [
                      Container(height: 20, width: 120, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder:
                          (_, __) => Container(
                            width: 80,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // 🏠 Super Hatch cards (3 skeletons)
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 150,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    height: 14,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    height: 12,
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    height: 12,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 👇 Shimmer loader method
  Widget _buildShimmerLoader() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 16, width: 150, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 14, width: 100, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 80, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // 👇 Reusable card for real data
  Widget _buildSuperHatchCard(dynamic result) {
    print("Result ID: ${result.id}");
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        // Get.to(() => Page())
        onTap:
            () =>
                Get.to(() => LocalsProfileForTouristScreen(localId: result.id)),
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
                  child:
                      result.offers?.photos != null &&
                              result.offers!.photos!.isNotEmpty
                          ? Image.network(
                            result.offers!.photos!.first,
                            fit: BoxFit.cover,
                          )
                          : (result.profileImage != null
                              ? Image.network(
                                result.profileImage!,
                                fit: BoxFit.cover,
                              )
                              : Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )),
                ),
              ),
              const SizedBox(width: 12),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name + Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${result.firstName} ${result.lastName}",
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

                    /// Offer
                    Text(
                      result.offers?.title ?? 'No title available',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      result.offers?.description ?? 'No description available',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),

                    /// Rating + Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            SizedBox(width: 4),
                            Text(
                              "${result.averageRating ?? '0.0'}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'from ',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                            Text(
                              "${result.offers?.pricePerPerson ?? '0.0'}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(' / person', style: TextStyle(fontSize: 12)),
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
  }
}
