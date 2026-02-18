import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
// import 'package:google_places_autocomplete/google_places_autocomplete.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';
import '../../../../../core/widgets/choose_country/model/country.dart';
import 'search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  final String? initialSearchQuery;

  const SearchScreen({Key? key, this.initialSearchQuery}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // int selectedDate = 1;
  List<DateTime> selectedDates = [];
  List<String> formattedDates = [];
  int guestCount = 2;
  DateTime currentMonth = DateTime(2025, 12, 1);
  Set<String> selectedLanguages = {'English'};
  List<String> formattedSelectedLanguages = [];
  String? selectedService;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> suggestionResults = [];
  int? crossAxisCount;

  String get selectedRange {
    if (selectedDates.isEmpty) return "";
    selectedDates.sort((a, b) => a.compareTo(b));
    final start = selectedDates.first;
    final end = selectedDates.last;
    return "${start.day} ${_monthName(start.month)} ${start.year} "
        "${end.day} ${_monthName(end.month)} ${end.year}";
  }

  List<String> formatSelectedDates(List<DateTime> selectedDates) {
    formattedDates =
        selectedDates.map((d) {
          final formatted =
              "${d.year.toString().padLeft(4, '0')}-"
              "${d.month.toString().padLeft(2, '0')}-"
              "${d.day.toString().padLeft(2, '0')}";
          return "$formatted"; // wrap in quotes
        }).toList();
    return formattedDates;
  }

  // List<String> formatSelectedLanguages(Set<String> selectedLanguages) {
  //   formattedSelectedLanguages =
  //       selectedLanguages.map((language) {
  //         return language.contains('(')
  //             ? language.split('(')[0].trim()
  //             : language;
  //       }).toList();

  //   return formattedSelectedLanguages;
  // }

  List<String> formatSelectedLanguages(Set<String> selectedLanguages) {
    formattedSelectedLanguages =
        selectedLanguages.map((language) {
          final match = RegExp(r'\((.*?)\)').firstMatch(language);
          if (match != null) {
            // Always take the part inside parentheses
            return '"${match.group(1)!.trim()}"';
          } else {
            // No parentheses → keep as is
            return '"${language.trim()}"';
          }
        }).toList();

    return formattedSelectedLanguages;
  }

  String _monthName(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month];
  }

  // final List<List<int?>> dates = [
  //   [null, null, null, null, null, null, 1],
  //   [2, 3, 4, 5, 6, 7, 8],
  //   [9, 10, 11, 12, 13, 14, 15],
  //   [16, 17, 18, 19, 20, 21, 22],
  //   [23, 24, 25, 26, 27, 28, 29],
  //   [30, 31, null, null, null, null, null],
  // ];

  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  final List<Map<String, dynamic>> services = [
    {
      'image': 'assets/icons/home.png',
      'label': 'At Home',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/restaurant.png',
      'label': 'Restaurant',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/takeAway.png',
      'label': 'Takeaway',
      'color': Colors.white,
    },

    {
      'image': 'assets/icons/dayTrip.png',
      'label': 'Day Trip',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/manualActivity.png',
      'label': 'Manual Activity',
      'color': Colors.white,
    },
    {'image': 'assets/icons/spa.png', 'label': 'Spa', 'color': Colors.white},
    {
      'image': 'assets/icons/journey.png',
      'label': 'Journey',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/islandHopping.png',
      'label': 'Island Hopping',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/arrivalDeparture.png',
      'label': 'Arrival Departure',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/weekTour.png',
      'label': 'Week Tour',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/dayTour.png',
      'label': 'Day Tour',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/rental.png',
      'label': 'Rental',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/droneRental.png',
      'label': 'Drone Rental',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/photo.png',
      'label': 'Photo',
      'color': Colors.white,
    },

    {
      'image': 'assets/icons/coach.png',
      'label': 'Coach',
      'color': Colors.white,
    },
    {'image': 'assets/icons/yoga.png', 'label': 'Yoga', 'color': Colors.white},
    {
      'image': 'assets/icons/museums.png',
      'label': 'Museums',
      'color': Colors.white,
    },
    {
      'image': 'assets/icons/monuments.png',
      'label': 'Monuments',
      'color': Colors.white,
    },
  ];
  // final String _apiKey = 'YOUR_API_KEY';
  // late GooglePlacesAutocomplete _placesService;
  // List<Prediction> _predictions = [];
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialSearchQuery != null) {
      //
      searchController.text = widget.initialSearchQuery!;
      _onSearchChanged(widget.initialSearchQuery!);
    }
  }

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() => suggestionResults = []);
      return;
    }

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=10',
    );

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'FlutterApp/1.0 (youremail@example.com)'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          suggestionResults = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching places: $e');
    }
  }

  // void _onSearchChanged(String query) {
  //   if (query.isEmpty) {
  //     setState(() => suggestionResults = []);
  //     return;
  //   }

  //   setState(() {
  //     suggestionResults =
  //         countries
  //             .where(
  //               (country) =>
  //                   country.country.toLowerCase().contains(query.toLowerCase()),
  //             )
  //             .toList();
  //   });
  // }

  void _onSuggestionTap(Country country) {
    setState(() {
      searchController.text = country.country;
      suggestionResults = [];
    });
    FocusScope.of(context).unfocus(); // close keyboard
  }

  // void _selectDate(int date) {
  //   setState(() {
  //     selectedDate = date;
  //   });
  // }

  void _changeGuestCount(int change) {
    setState(() {
      guestCount = (guestCount + change).clamp(1, 20);
    });
  }

  void _selectService(String service) {
    setState(() {
      selectedService = selectedService == service ? null : service;
    });
  }

  void _showLanguageSelector() {
    List<Country> filteredCountries = countries;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              void onSearch(String query) {
                setModalState(() {
                  filteredCountries =
                      countries
                          .where(
                            (country) => country.name.toLowerCase().contains(
                              query.toLowerCase(),
                            ),
                          )
                          .toList();
                });
              }

              void onSelect(Country country) {
                setModalState(() {
                  if (selectedLanguages.contains(country.name)) {
                    selectedLanguages.remove(country.name);
                  } else {
                    selectedLanguages.add(country.name);
                  }
                });
                setState(() {}); // Update parent state
              }

              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      'What is your spoken language?',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        wordSpacing: 2,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    foregroundColor: Colors.black,
                  ),
                  body: Column(
                    children: [
                      // Search Box
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          onChanged: onSearch,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Choose your language",
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      // Language List
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.separated(
                            itemCount: filteredCountries.length,
                            separatorBuilder:
                                (_, __) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final country = filteredCountries[index];
                              return ListTile(
                                leading: Text(
                                  country.flagEmoji,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                title: Text(
                                  country.name,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                trailing:
                                    selectedLanguages.contains(country.name)
                                        ? const Icon(
                                          Icons.check,
                                          color: Colors.red,
                                        )
                                        : null,
                                onTap: () => onSelect(country),
                              );
                            },
                          ),
                        ),
                      ),
                      // Continue Button
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                        ),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed:
                                selectedLanguages.isNotEmpty
                                    ? () {
                                      Navigator.pop(context);
                                    }
                                    : null,
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  // void _navigateToResults() {
  //   Map<String, dynamic> searchParams = {
  //     'query': searchController.text,
  //     // 'date': 'December $selectedDate, 2024',
  //     // 'date': selectedDate,
  //     'guests': guestCount,
  //     'languages': selectedLanguages.toList(),
  //     'service': selectedService,
  //   };

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SearchResultsScreen(searchParams: searchParams),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        hintText: 'Search destinations, hotels...',
                        // prefixIcon: Icon(Icons.search, color: Colors.grey),
                        suffixIcon: Icon(Icons.search, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),

                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Suggestions
            // if (suggestionResults.isNotEmpty)
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount: suggestionResults.length,
            //       itemBuilder: (context, index) {
            //         final country = suggestionResults[index];
            //         return ListTile(
            //           leading: Text(
            //             country.flagEmoji,
            //             style: TextStyle(fontSize: 20),
            //           ),
            //           title: Text(country.country),
            //           onTap: () => _onSuggestionTap(country),
            //         );
            //       },
            //     ),
            //   ),
            if (suggestionResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: suggestionResults.length,
                  itemBuilder: (context, index) {
                    final place = suggestionResults[index];
                    return ListTile(
                      leading: Icon(Icons.location_on, color: Colors.grey),
                      title: Text(place['display_name']),
                      onTap: () {
                        setState(() {
                          searchController.text = place['display_name'];
                          suggestionResults = [];
                        });
                        FocusScope.of(context).unfocus();
                      },
                    );
                  },
                ),
              ),

            // // If no results
            // if (suggestionResults.isEmpty && searchController.text.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Text(
            //       "No results found",
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //   ),

            // Header with back button and search bar
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   child: Row(
            //     children: [
            //       IconButton(
            //         onPressed: () => Navigator.pop(context),
            //         icon: Icon(Icons.arrow_back),
            //         padding: EdgeInsets.zero,
            //       ),
            //       SizedBox(width: 8),
            //       Expanded(
            //         child: TextField(
            //           controller: searchController,
            //           decoration: InputDecoration(
            //             hintText: 'Search destinations, hotels...',
            //             prefixIcon: Icon(Icons.search, color: Colors.grey),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(8),
            //               borderSide: BorderSide(color: Colors.grey[300]!),
            //             ),
            //             contentPadding: EdgeInsets.symmetric(vertical: 12),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Selection
                    Text(
                      'What date are you looking for?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     BackButton(color: Colors.black),
                        //     'Manage Availability'.text22Black700(),
                        //     const SizedBox(width: 50),
                        //   ],
                        // ),
                        const SizedBox(height: 20),

                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  onPressed: () {
                                    setState(() {
                                      currentMonth = DateTime(
                                        currentMonth.year,
                                        currentMonth.month - 1,
                                      );
                                    });
                                  },
                                ),
                                Text(
                                  "${_monthName(currentMonth.month)} ${currentMonth.year}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  onPressed: () {
                                    setState(() {
                                      currentMonth = DateTime(
                                        currentMonth.year,
                                        currentMonth.month + 1,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),

                            if (selectedRange.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  selectedRange,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        // Calendar Header

                        // Calendar
                        Container(
                          height: size.height * 0.35,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              // Weekdays
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children:
                                      ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                                          .map(
                                            (day) => Expanded(
                                              child: Center(
                                                child: Text(
                                                  day,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                              SizedBox(height: 10),

                              // Calendar Grid
                              Expanded(child: _buildCalendarGrid()),
                            ],
                          ),
                        ),

                        // Time Slots
                      ],
                    ),

                    // Guest Count
                    Text(
                      'How many are you?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
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
                            onTap: () => _changeGuestCount(-1),
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              '0' + '$guestCount',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _changeGuestCount(1),
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

                    // Language Selection - Exactly like your code
                    Text(
                      'What languages do you speak?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: _showLanguageSelector,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (selectedLanguages.isNotEmpty) ...[
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    selectedLanguages.map((language) {
                                      // Extract just the language name (before parentheses if exists)
                                      String displayName =
                                          language.contains('(')
                                              ? language.split('(')[0].trim()
                                              : language;

                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              displayName,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedLanguages.remove(
                                                    language,
                                                  );
                                                });
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              ),
                              SizedBox(height: 8),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedLanguages.isEmpty
                                      ? 'Choose your language'
                                      : 'Tap to add more languages',
                                  style: TextStyle(
                                    color:
                                        selectedLanguages.isEmpty
                                            ? Colors.black54
                                            : Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 36),

                    // Services
                    Text(
                      'What offer do you want to take?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),

                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount:
                    //         MediaQuery.of(context).size.width < 600
                    //             ? 3
                    //             : 4, // 3 items on small screens, 4 on larger
                    //     crossAxisSpacing: 8,
                    //     mainAxisSpacing: 8,
                    //     childAspectRatio: 1.0,
                    //   ),
                    //   itemCount: services.length,
                    //   itemBuilder: (context, index) {
                    //     final service = services[index];
                    //     final isSelected = selectedService == service['label'];

                    //     final screenWidth = MediaQuery.of(context).size.width;
                    //     final crossAxisCount = screenWidth < 300 ? 3 : 4;
                    //     final spacing = 8.0;
                    //     final itemWidth =
                    //         (screenWidth - (crossAxisCount + 1) * spacing) /
                    //         crossAxisCount;

                    //     // Responsive sizes
                    //     final imageSize = itemWidth * 0.6;
                    //     final fontSize = (itemWidth * 0.12).clamp(
                    //       10.0,
                    //       14.0,
                    //     ); // min 10, max 16

                    //     return GestureDetector(
                    //       onTap: () => _selectService(service['label']),
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //           vertical: 8,
                    //           horizontal: 4,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //           border: Border.all(
                    //             color:
                    //                 isSelected ? Colors.red : Colors.grey[200]!,
                    //             width: isSelected ? 2 : 1,
                    //           ),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.1),
                    //               blurRadius: 4,
                    //               offset: Offset(0, 2),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Container(
                    //               width: imageSize,
                    //               height: imageSize,
                    //               decoration: BoxDecoration(
                    //                 color:
                    //                     isSelected
                    //                         ? Colors.red[100]
                    //                         : Colors.white,
                    //                 borderRadius: BorderRadius.circular(8),
                    //               ),
                    //               alignment: Alignment.center,
                    //               child: Image.asset(
                    //                 service['image'],
                    //                 width: imageSize * 0.9,
                    //                 height: imageSize * 0.9,
                    //                 fit: BoxFit.contain,
                    //               ),
                    //             ),
                    //             SizedBox(height: itemWidth * 0.08),
                    //             Flexible(
                    //               child: FittedBox(
                    //                 fit: BoxFit.scaleDown,
                    //                 child: Text(
                    //                   service['label'],
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                     fontSize: fontSize,
                    //                     fontWeight: FontWeight.w500,
                    //                     color:
                    //                         isSelected
                    //                             ? Colors.red
                    //                             : Colors.black,
                    //                   ),
                    //                   maxLines: 2,
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // screenWidth < 600
                    //     ?
                    //                     if four item is a row of 4
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            4, // adjust based on screen size if needed
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.9, // slightly taller for text
                      ),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        final isSelected = selectedService == service['label'];

                        // Responsive sizing
                        final size = MediaQuery.of(context).size;
                        final itemWidth =
                            (size.width - (8 * (4 + 1))) /
                            4; // total width minus spacing
                        final imageSize =
                            itemWidth * 0.6; // image occupies 60% of item width
                        final fontSize =
                            itemWidth * 0.12; // font scales with width

                        return GestureDetector(
                          onTap: () => _selectService(service['label']),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    isSelected ? Colors.red : Colors.grey[200]!,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: imageSize,
                                  height: imageSize,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.red[100]
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    service['image'],
                                    width: imageSize * 0.9,
                                    height: imageSize * 0.9,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: itemWidth * 0.08),
                                Flexible(
                                  child: Text(
                                    service['label'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isSelected
                                              ? Colors.red
                                              : Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // :
                    // // // if in a row 3 item in a row
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //       SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 3,
                    //         crossAxisSpacing: 16,
                    //         mainAxisSpacing: 16,
                    //         childAspectRatio: 1,
                    //       ),
                    //   itemCount: services.length,
                    //   itemBuilder: (context, index) {
                    //     final service = services[index];
                    //     final isSelected =
                    //         selectedService == service['label'];
                    //     // Get screen size
                    //     final size = MediaQuery.of(context).size;
                    //     final imageSize =
                    //         size.width * 0.18; // 15% of screen width
                    //     final fontSize =
                    //         size.width * 0.028; // 3.5% of screen width
                    //     return GestureDetector(
                    //       onTap: () => _selectService(service['label']),
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //           border: Border.all(
                    //             color:
                    //                 isSelected
                    //                     ? Colors.red
                    //                     : Colors.grey[200]!,
                    //             width: isSelected ? 2 : 1,
                    //           ),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.1),
                    //               blurRadius: 4,
                    //               offset: Offset(0, 2),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Container(
                    //               width: imageSize,
                    //               height: imageSize,
                    //               decoration: BoxDecoration(
                    //                 color:
                    //                     isSelected
                    //                         ? Colors.red[100]
                    //                         : Colors.white,
                    //                 borderRadius: BorderRadius.circular(8),
                    //               ),
                    //               alignment: Alignment.center,
                    //               child: Image.asset(
                    //                 service['image'],
                    //                 width:
                    //                     imageSize *
                    //                     0.9, // image occupies 70% of container
                    //                 height: imageSize * 0.8,
                    //                 fit: BoxFit.contain,
                    //               ),
                    //             ),
                    //             SizedBox(height: imageSize * 0.08),
                    //             Text(
                    //               service['label'],
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                 fontSize: fontSize,
                    //                 fontWeight: FontWeight.w500,
                    //                 color:
                    //                     isSelected
                    //                         ? Colors.red
                    //                         : Colors.black,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    SizedBox(height: 32),
                    WideCustomButton(
                      text: 'Continue',
                      onPressed: () {
                        formattedDates = formatSelectedDates(selectedDates);
                        formattedSelectedLanguages = formatSelectedLanguages(
                          selectedLanguages,
                        );

                        print(
                          "Selected dates: $formattedDates\n"
                          "Selected languages: $formattedSelectedLanguages\n"
                          "Guest count: $guestCount\n"
                          "Service: $selectedService\n"
                          "Search Country: ${searchController.text}",
                        );

                        if (searchController.text.isEmpty) {
                          Get.snackbar("Error", "Please select a country");
                          return;
                        }

                        Get.to(
                          () => SearchResultsScreen(
                            searchCountry: searchController.text,
                            selectedDates: formattedDates,
                            selectedPerticipants: guestCount,
                            selectedLanguages: selectedLanguages.toList(),
                            selectedOfferType: selectedService ?? '',
                          ),
                        );
                      },
                    ),

                    // Continue Button
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: _navigateToResults,
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.red,
                    //       padding: EdgeInsets.symmetric(vertical: 16),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       'Continue',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isSelected = selectedDates.any(
        (d) =>
            d.year == date.year && d.month == date.month && d.day == date.day,
      );

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedDates.removeWhere(
                  (d) =>
                      d.year == date.year &&
                      d.month == date.month &&
                      d.day == date.day,
                );
              } else {
                selectedDates.add(date);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFFFE1E5) : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Color(0xFFFF3951) : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: dayWidgets,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
