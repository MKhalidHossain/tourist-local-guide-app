import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/home/controllers/home_controller.dart';
import 'package:kobeur/feature/home/presentation/widgets/favorite_button.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../profile/presentation/screens/local/locals_profile_for_tourist_show.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchCountry;
  final List<String> selectedDates;
  final int selectedPerticipants;
  final List<String> selectedLanguages;
  final String selectedOfferType;

  const SearchResultsScreen({
    super.key,
    required this.searchCountry,
    required this.selectedDates,
    required this.selectedPerticipants,
    required this.selectedLanguages,
    required this.selectedOfferType,
  });

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredResults = [];
  List<dynamic> originalResults = [];

  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      homeController = Get.find<HomeController>();
      await homeController.searchOffer(
        widget.searchCountry,
        widget.selectedDates,
        widget.selectedPerticipants,
        widget.selectedLanguages,
        widget.selectedOfferType,
      );
      if (homeController.searchOfferResponseModel.data != null) {
        setState(() {
          originalResults = List.from(
            homeController.searchOfferResponseModel.data!,
          );
          filteredResults = List.from(originalResults);
        });
      }
    });
  }

  /// 🔍 Search filter
  void _onSearchChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredResults = List.from(originalResults);
      } else {
        filteredResults =
            originalResults.where((result) {
              final fullName =
                  "${result.firstName ?? ''} ${result.lastName ?? ''}"
                      .toLowerCase();
              final offerTitle =
                  result.offers?.first.title?.toLowerCase() ?? '';
              final offerDesc =
                  result.offers?.first.description?.toLowerCase() ?? '';
              return fullName.contains(value.toLowerCase()) ||
                  offerTitle.contains(value.toLowerCase()) ||
                  offerDesc.contains(value.toLowerCase());
            }).toList();
      }
    });
  }

  /// 🔽 Sorting
  void _sortResults(String criteria) {
    setState(() {
      switch (criteria) {
        case 'price_low':
          filteredResults.sort(
            (a, b) => (a.offers?.first.pricePerPerson ?? 0).compareTo(
              b.offers?.first.pricePerPerson ?? 0,
            ),
          );
          break;
        case 'price_high':
          filteredResults.sort(
            (a, b) => (b.offers?.first.pricePerPerson ?? 0).compareTo(
              a.offers?.first.pricePerPerson ?? 0,
            ),
          );
          break;
        case 'rating':
          filteredResults.sort(
            (a, b) => (b.offers?.first.rating ?? 0).compareTo(
              a.offers?.first.rating ?? 0,
            ),
          );
          break;
        case 'name':
          filteredResults.sort(
            (a, b) => ("${a.firstName} ${a.lastName}").compareTo(
              "${b.firstName} ${b.lastName}",
            ),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 📱 responsive size

    return GetBuilder<HomeController>(
      builder: (homeController) {
        return homeController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    // Back button + Search bar + Filter
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          PopupMenuButton<String>(
                            onSelected: _sortResults,
                            icon: const Icon(Icons.sort),
                            itemBuilder:
                                (context) => const [
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
                                  PopupMenuItem(
                                    value: 'name',
                                    child: Text('Name A-Z'),
                                  ),
                                ],
                          ),
                        ],
                      ),
                    ),

                    // Results count
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${filteredResults.length} results found',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),

                    // Results list
                    Expanded(
                      child:
                          filteredResults.isEmpty
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                                separatorBuilder:
                                    (_, __) =>
                                        SizedBox(height: size.height * 0.015),
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04,
                                ),
                                itemCount: filteredResults.length,
                                itemBuilder: (context, index) {
                                  final result = filteredResults[index];
                                  final hatchName =
                                      "${result.firstName ?? ''} ${result.lastName ?? ''}";
                                  final profileIamge = result.profileImage;
                                  return GestureDetector(
                                    onTap:
                                        () => Get.to(
                                          () => LocalsProfileForTouristScreen(
                                            localId: result.id ?? "",
                                          ),
                                        ),
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        0,
                                        // size.width * 0.03,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Thumbnail (responsive)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: SizedBox(
                                              width: size.width * 0.295,
                                              height: size.width * 0.295,
                                              child:
                                                  (result.offers?.isNotEmpty ??
                                                              false) &&
                                                          (result
                                                                  .offers!
                                                                  .first
                                                                  .photos
                                                                  ?.isNotEmpty ??
                                                              false)
                                                      ? Image.network(
                                                        // result
                                                        //     .offers!
                                                        //     .first
                                                        //     .photos!
                                                        //     .first,
                                                        profileIamge,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (
                                                          context,
                                                          child,
                                                          progress,
                                                        ) {
                                                          if (progress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Shimmer.fromColors(
                                                            baseColor:
                                                                Colors
                                                                    .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100]!,
                                                            child: Container(
                                                              color:
                                                                  Colors
                                                                      .grey[300],
                                                            ),
                                                          );
                                                        },
                                                        errorBuilder:
                                                            (
                                                              _,
                                                              __,
                                                              ___,
                                                            ) => Image.asset(
                                                              'assets/images/bannerPlaceholder.jpg',
                                                              fit: BoxFit.cover,
                                                            ),
                                                      )
                                                      : Image.asset(
                                                        'assets/images/bannerPlaceholder.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.03),

                                          // Info
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        hatchName,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const FavoriteButton(
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height:
                                                              size.height *
                                                              0.045,
                                                          width:
                                                              size.height *
                                                              0.045,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                Colors
                                                                    .grey[100],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4,
                                                                ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4,
                                                                ),
                                                            child: Builder(
                                                              builder: (
                                                                context,
                                                              ) {
                                                                final photoUrl =
                                                                    (result.offers !=
                                                                                null &&
                                                                            result.offers!.isNotEmpty &&
                                                                            result.offers!.first.photos !=
                                                                                null &&
                                                                            result.offers!.first.photos!.isNotEmpty)
                                                                        ? result
                                                                            .offers!
                                                                            .first
                                                                            .photos!
                                                                            .first
                                                                        : null;

                                                                if (photoUrl ==
                                                                        null ||
                                                                    photoUrl
                                                                        .isEmpty) {
                                                                  return Image.asset(
                                                                    'assets/images/bannerPlaceholder.jpg',
                                                                    fit:
                                                                        BoxFit
                                                                            .cover,
                                                                  );
                                                                }

                                                                return Image.network(
                                                                  photoUrl,
                                                                  fit:
                                                                      BoxFit
                                                                          .cover,
                                                                  loadingBuilder: (
                                                                    context,
                                                                    child,
                                                                    loadingProgress,
                                                                  ) {
                                                                    if (loadingProgress ==
                                                                        null)
                                                                      return child;
                                                                    return Shimmer.fromColors(
                                                                      baseColor:
                                                                          Colors
                                                                              .grey[300]!,
                                                                      highlightColor:
                                                                          Colors
                                                                              .grey[100]!,
                                                                      child: Container(
                                                                        color:
                                                                            Colors.grey[300],
                                                                      ),
                                                                    );
                                                                  },
                                                                  errorBuilder: (
                                                                    context,
                                                                    error,
                                                                    stackTrace,
                                                                  ) {
                                                                    return Image.asset(
                                                                      'assets/images/bannerPlaceholder.jpg',
                                                                      fit:
                                                                          BoxFit
                                                                              .cover,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),

                                                        Text(
                                                          result
                                                                  .offers
                                                                  ?.first
                                                                  .offerType ??
                                                              'No Offer Type',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 8),

                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            result
                                                                    .offers
                                                                    ?.first
                                                                    .title ??
                                                                'No Category',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                ),
                                                          ),
                                                          Text(
                                                            result
                                                                    .offers
                                                                    ?.first
                                                                    .description ??
                                                                'No Description',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .grey[600],
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.005,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          '${result.averageRating ?? 0.00}',
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        '${result.offers?.first.pricePerPerson ?? 0}€'
                                                            .text14Red(),

                                                        '/ person '
                                                            .text14Black(),
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
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
