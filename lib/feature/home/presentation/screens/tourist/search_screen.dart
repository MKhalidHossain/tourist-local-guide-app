import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';
import '../../../../../core/widgets/choose_country/model/country.dart';
import '../../widgets/date_picker.dart';
import 'search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  final String? initialSearchQuery;

  const SearchScreen({Key? key, this.initialSearchQuery}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedDate = 1;
  int guestCount = 2;
  String currentMonth = 'Dec 2024';
  Set<String> selectedLanguages = {'中文 (Chinese)'};
  String? selectedService;
  TextEditingController searchController = TextEditingController();

  final List<List<int?>> dates = [
    [null, null, null, null, null, null, 1],
    [2, 3, 4, 5, 6, 7, 8],
    [9, 10, 11, 12, 13, 14, 15],
    [16, 17, 18, 19, 20, 21, 22],
    [23, 24, 25, 26, 27, 28, 29],
    [30, 31, null, null, null, null, null],
  ];

  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  final List<Map<String, dynamic>> services = [
    {'icon': '🏨', 'label': 'Hotel', 'color': Colors.blue[100]},
    {'icon': '🏠', 'label': 'At Home', 'color': Colors.green[100]},
    {'icon': '🏖️', 'label': 'Resort', 'color': Colors.yellow[100]},
    {'icon': '✈️', 'label': 'Flight', 'color': Colors.purple[100]},
    {'icon': '🚗', 'label': 'Car rental', 'color': Colors.orange[100]},
    {'icon': '🎯', 'label': 'Tour', 'color': Colors.pink[100]},
    {'icon': '🌍', 'label': 'World', 'color': Colors.teal[100]},
    {'icon': '📸', 'label': 'Photo', 'color': Colors.indigo[100]},
    {'icon': '🎪', 'label': 'Event', 'color': Colors.red[100]},
    {'icon': '🎁', 'label': 'Other', 'color': Colors.brown[100]},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialSearchQuery != null) {
      searchController.text = widget.initialSearchQuery!;
    }
  }

  void _selectDate(int date) {
    setState(() {
      selectedDate = date;
    });
  }

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

  void _navigateToResults() {
    Map<String, dynamic> searchParams = {
      'query': searchController.text,
      'date': 'December $selectedDate, 2024',
      'guests': guestCount,
      'languages': selectedLanguages.toList(),
      'service': selectedService,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(searchParams: searchParams),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and search bar
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
                      decoration: InputDecoration(
                        hintText: 'Search destinations, hotels...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                    CustomStyledCalendar(
                      onDateSelected: (date) {
                        print("Picked date: $date"); // e.g. 08/12/25
                      },
                    ),

                    // SizedBox(height: 16),

                    // Month Navigation
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(Icons.chevron_left),
                    //     ),
                    //     Text(
                    //       currentMonth,
                    //       style: TextStyle(fontWeight: FontWeight.w500),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(Icons.chevron_right),
                    //     ),
                    //   ],
                    // ),

                    // Calendar
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 16),
                    //   child: Column(
                    //     children: [
                    //       // Week days
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children:
                    //             weekDays
                    //                 .map(
                    //                   (day) => Container(
                    //                     width: 40,
                    //                     height: 32,
                    //                     alignment: Alignment.center,
                    //                     child: Text(
                    //                       day,
                    //                       style: TextStyle(
                    //                         color: Colors.grey,
                    //                         fontSize: 12,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 )
                    //                 .toList(),
                    //       ),
                    //       // Calendar dates
                    //       ...dates
                    //           .map(
                    //             (week) => Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               children:
                    //                   week
                    //                       .map(
                    //                         (date) => Container(
                    //                           width: 40,
                    //                           height: 40,
                    //                           child:
                    //                               date != null
                    //                                   ? GestureDetector(
                    //                                     onTap:
                    //                                         () => _selectDate(
                    //                                           date,
                    //                                         ),
                    //                                     child: Container(
                    //                                       decoration: BoxDecoration(
                    //                                         color:
                    //                                             date ==
                    //                                                     selectedDate
                    //                                                 ? Colors.red
                    //                                                 : Colors
                    //                                                     .transparent,
                    //                                         shape:
                    //                                             BoxShape.circle,
                    //                                       ),
                    //                                       alignment:
                    //                                           Alignment.center,
                    //                                       child: Text(
                    //                                         '$date',
                    //                                         style: TextStyle(
                    //                                           color:
                    //                                               date ==
                    //                                                       selectedDate
                    //                                                   ? Colors
                    //                                                       .white
                    //                                                   : Colors
                    //                                                       .black,
                    //                                           fontWeight:
                    //                                               date ==
                    //                                                       selectedDate
                    //                                                   ? FontWeight
                    //                                                       .w600
                    //                                                   : FontWeight
                    //                                                       .normal,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   )
                    //                                   : SizedBox(),
                    //                         ),
                    //                       )
                    //                       .toList(),
                    //             ),
                    //           )
                    //           .toList(),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 36),

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
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        final isSelected = selectedService == service['label'];
                        return GestureDetector(
                          onTap: () => _selectService(service['label']),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.red[100]
                                            : service['color'],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    service['icon'],
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  service['label'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected ? Colors.red : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 32),
                    WideCustomButton(
                      text: 'Continue',
                      onPressed:
                          // () {
                          //   Get.to(SearchResultsScreen());
                          // },
                          _navigateToResults,
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
}
