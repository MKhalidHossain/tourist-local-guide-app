import 'package:get/get.dart';

class NavigationHelper {
  // Get the next route based on current screen and selected data
  static String getNextRoute(
    String currentScreen, {
    Map<String, dynamic>? data,
  }) {
    switch (currentScreen) {
      case 'category-selection':
        return '/generic-offers'; // This will be handled dynamically

      case 'generic-offers':
        String category = data?['category']?.toLowerCase() ?? '';
        switch (category) {
          case 'photography':
            return '/time-setting-photography';
          case 'sport':
            return '/time-setting-sport';
          default:
            return '/time-setting';
        }

      case 'time-setting':
      case 'time-setting-photography':
      case 'time-setting-sport':
        return '/photo-upload';

      case 'photo-upload':
        return '/photo-preview';

      case 'photo-preview':
        return '/date-selection';

      case 'date-selection':
        return '/time-selection';

      case 'time-selection':
        return '/service-complete'; // Or wherever you want to go after time selection

      default:
        return '/';
    }
  }

  // Navigate to next screen with proper data passing
  static void navigateNext(String currentScreen, {Map<String, dynamic>? data}) {
    String nextRoute = getNextRoute(currentScreen, data: data);

    if (data != null) {
      Get.toNamed(nextRoute, arguments: data);
    } else {
      Get.toNamed(nextRoute);
    }
  }
}
