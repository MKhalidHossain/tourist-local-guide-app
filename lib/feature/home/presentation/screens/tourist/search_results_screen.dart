import 'package:flutter/material.dart';
import 'package:kobeur/feature/home/presentation/widgets/favorite_button.dart';

class SearchResultsScreen extends StatefulWidget {
  final Map<String, dynamic>? searchParams;

  const SearchResultsScreen({Key? key, this.searchParams}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredResults = [];

  final List<Map<String, dynamic>> allResults = [
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

  @override
  void initState() {
    super.initState();
    filteredResults = List.from(allResults);

    // Set search query from parameters
    if (widget.searchParams != null) {
      String searchQuery = '';
      final params = widget.searchParams!;

      if (params['query'] != null && params['query'].isNotEmpty) {
        searchQuery += params['query'];
      }

      if (params['service'] != null) {
        searchQuery += ' ${params['service']}';
      }

      if (params['date'] != null) {
        searchQuery += ' ${params['date']}';
      }

      if (params['guests'] != null) {
        searchQuery += ' ${params['guests']} guests';
      }

      searchController.text = searchQuery.trim();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredResults = List.from(allResults);
      } else {
        filteredResults =
            allResults.where((result) {
              return result['name'].toLowerCase().contains(
                    value.toLowerCase(),
                  ) ||
                  result['location'].toLowerCase().contains(
                    value.toLowerCase(),
                  ) ||
                  result['description'].toLowerCase().contains(
                    value.toLowerCase(),
                  );
            }).toList();
      }
    });
  }

  void _onResultTapped(Map<String, dynamic> result) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                        // shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          result['image'],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            result['location'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            result['description'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '${result['rating']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '(${result['reviews']})',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Price: \$${result['price']} per session',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),

                // Show search parameters if available
                if (widget.searchParams != null) ...[
                  Text(
                    'Booking Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.searchParams!['date'] != null)
                          Text(
                            'Date: ${widget.searchParams!['date']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        if (widget.searchParams!['guests'] != null)
                          Text(
                            'Guests: ${widget.searchParams!['guests']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        if (widget.searchParams!['language'] != null)
                          Text(
                            'Language: ${widget.searchParams!['language']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        if (widget.searchParams!['service'] != null)
                          Text(
                            'Service: ${widget.searchParams!['service']}',
                            style: TextStyle(fontSize: 14),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],

                Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Text(
                  'Experienced ${result['description'].toLowerCase()} with over 5 years of experience in Bali. Specializing in capturing beautiful moments with professional quality.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added ${result['name']} to favorites',
                              ),
                            ),
                          );
                        },
                        child: Text('Add to Favorites'),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showBookingDialog(result);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  void _showBookingDialog(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Book ${result['name']}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Service: ${result['description']}'),
                Text('Location: ${result['location']}'),
                Text('Price: \$${result['price']} per session'),
                if (widget.searchParams != null) ...[
                  SizedBox(height: 16),
                  Text('Your booking details:'),
                  if (widget.searchParams!['date'] != null)
                    Text('Date: ${widget.searchParams!['date']}'),
                  if (widget.searchParams!['guests'] != null)
                    Text('Guests: ${widget.searchParams!['guests']}'),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Booking confirmed with ${result['name']}!',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _sortResults(String criteria) {
    setState(() {
      switch (criteria) {
        case 'price_low':
          filteredResults.sort((a, b) => a['price'].compareTo(b['price']));
          break;
        case 'price_high':
          filteredResults.sort((a, b) => b['price'].compareTo(a['price']));
          break;
        case 'rating':
          filteredResults.sort((a, b) => b['rating'].compareTo(a['rating']));
          break;
        case 'name':
          filteredResults.sort((a, b) => a['name'].compareTo(b['name']));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('9:41', style: TextStyle(fontWeight: FontWeight.w600)),
            //       Row(
            //         children: [
            //           Container(
            //             width: 16,
            //             height: 8,
            //             decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(2),
            //             ),
            //           ),
            //           SizedBox(width: 2),
            //           Container(
            //             width: 16,
            //             height: 8,
            //             decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(2),
            //             ),
            //           ),
            //           SizedBox(width: 2),
            //           Container(
            //             width: 16,
            //             height: 8,
            //             decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(2),
            //             ),
            //           ),
            //           SizedBox(width: 2),
            //           Container(
            //             width: 24,
            //             height: 12,
            //             decoration: BoxDecoration(
            //               border: Border.all(color: Colors.black),
            //               borderRadius: BorderRadius.circular(2),
            //             ),
            //             child: Container(
            //               margin: EdgeInsets.all(1),
            //               decoration: BoxDecoration(
            //                 color: Colors.black,
            //                 borderRadius: BorderRadius.circular(1),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            // Back button and search bar
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  PopupMenuButton<String>(
                    onSelected: _sortResults,
                    icon: Icon(Icons.sort),
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 'price_low',
                            child: Text('Price: Low to High'),
                          ),
                          PopupMenuItem(
                            value: 'price_high',
                            child: Text('Price: High to Low'),
                          ),
                          PopupMenuItem(
                            value: 'rating',
                            child: Text('Highest Rating'),
                          ),
                          PopupMenuItem(value: 'name', child: Text('Name A-Z')),
                        ],
                  ),
                ],
              ),
            ),

            // Results Count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    '${filteredResults.length} results found',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Results List
            Expanded(
              child:
                  filteredResults.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Try adjusting your search terms',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                      : ListView.separated(
                        separatorBuilder: (_, __) => SizedBox(height: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredResults.length,
                        itemBuilder: (context, index) {
                          final result = filteredResults[index];
                          return GestureDetector(
                            onTap: () => _onResultTapped(result),
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 16),
                              // padding: EdgeInsets.all(16),
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
                                  Container(
                                    // width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.asset(
                                        result['image'],

                                        //'assets/images/local1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              result['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const FavoriteButton(size: 20),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
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
                                                    //overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

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
                                                  '${result['price']}\€',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '/ ',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  'person',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // Text(
                                            //   '(${result['reviews']})',
                                            //   style: TextStyle(
                                            //     color: Colors.grey,
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [],
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
    );
  }
}
