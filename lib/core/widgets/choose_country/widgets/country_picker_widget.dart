import 'package:flutter/material.dart';

import 'country_list_view.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Select Country")),
    // body: CountryListView(
    //   onSelect: onSelect,
    //   favorite: favorite,
    //   exclude: exclude,
    //   countryFilter: countryFilter,
    //   showPhoneCode: showPhoneCode,
    //   searchAutofocus: searchAutofocus,
    //   showWorldWide: showWorldWide,
    //   showSearch: showSearch,
    //   customFlagBuilder: customFlagBuilder,
    // ),
  );
}
