class Urls {
  // ................................Auth...............................with local or server

  static const String baseUrl = 'http://10.10.5.85:5001/api/v1';
  // static const String baseUrl = 'https://api.hatchr.app/api/v1';

  // Auth Module
  static const String register = '/auth/signup';
  static const String login = '/auth/login';
  static const String refreshAccessToken = '/auth/refresh-token';
  // static const String updateAccessAndRefreshToken = '/api/v1/auth/refresh-access-token';
  static const String changePassword = '/profile/change-password';
  static const String forgetPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyCode = '/auth/verify-otp';
  static const String logOut = '/auth/logout';

  static const String chooseRole = '/auth/choose-role';

  // ................................Profile Module...............................

  static const String getProfile = '/profile';

  static const String updateProfile = '/profile';

  // ................................Tourist Module...............................

  static const String getFristPage = '/tourist/home';

  static const String getSuperHatch = '/tourist/super-hatch';

  static const String getFavouriteHatch = '/tourist/favorites';

  static const String searchOffer = '/tourist/search';

  static const String getOfferDetails = '/tourist/offer/';

  static const String getLocalProfile = '/tourist/';

  static const String addFavouriteOrRemoveFavourite = '/tourist/favorite';

  static const String getFavorites = '/tourist/favorites';

  static const String rateALocal = '/tourist/rate-local';

  static const String cancelTripForTuourist = '/local/trip/cancel/';

  // ................................Booking  Module...............................

  static const String createBooking = '/booking/';

  static const String confirmBooking = '/booking/confirm-booking';

  static const String updateBooking = '/booking/';

  static const String getBookingDetails = '/booking/';

  static const String getBookingsByStatus = '/booking/cancel/';

  // ................................Local  Module...............................

  static const String createOffer = '/local/';

  static const String updateOffer = '/local/update';

  static const String getHome = '/local/';

  static const String getTripsDetails = '/local/trip/';

  // static const String getBookingsUpcoming = '/local/trips?status=upcoming';

  // static const String getBookingsConfirmed = '/local/trips?status=confirmed';
  static const String getBookingsAll = '/local/trips';

  static const String getBookingsCategories = '/local/trips?status=';

  static const String cencelBooking = '/local/trip/cancel/';

  // // ................................Booking Module...............................

  // static const String createBooking = '/booking/';

  // static const String confirmBooking = '/booking/confirm-booking';

  // static const String updateBooking = '/booking/:bookingId';

  // static const String getBookingDetails =
  //     '/booking/'; // need bookingId here in last of the url

  // static const String getBookingsByStatus = '/booking?status=confirmed';

  // ................................Message Module...............................

  static const String sendMessage = '/chat/message';

  static const String getMessage = '/chat/history/';

  static const String getUserAssociatWithChat = '/chat/list';

  // ................................Payment Module...............................

  // static const String sendMessage = '/chat/message';

  // static const String getMessage = '/messages/history/:receiverId';

  // static const String getUserAssociatWithChat = '/messages/list';

  // static const String getOfferDetails = '/api/v1/tasks/';

  // static const String getOfferDetails = '/api/v1/tasks/';

  //

  //

  //

  //   //commanders
  //   static const String createCommander = '/api/v1/commander';

  //   static const String getAllCommanders = '/api/v1/commander';

  //   //................................ If need to get filtered commanders
  //   // static const String getFilteredCommanders =
  //   //     '/api/v1/commander?page=1&limit=8&service=Army&unit=101st Division';

  //   static const String getSpecificCommanders = '/api/v1/commander/';

  //   //Services
  //   static const String getAllReviews = '/api/v1/review?page=1&limit=1';

  //   static const String createReview = '/api/v1/review';

  //   static const String getTopFiveReviews = '/api/v1/review/top-five';

  //   static const String getAllServices = '/api/v1/service?page=1&limit=10';

  //   static const String getAllBlogs =
  //       '/api/v1/blog?page=1&limit=100&slug=first-blogsdaf';

  //   static const String getABlogs = '/api/v1/blog/';

  //   static const String getAllCategoryBlogs = '/api/v1/blog/blog-category';

  //   static const String getAllUnits = '/api/v1/unit?page=1&limit=10';

  //   static const String getAllContact = '/api/v1/contact/';
  //   static const String getAllFeaturedReview = '/api/v1/review/featured-top-five';

  //   static const String commentUnderBlog = '/api/v1/blog/comment';
  //   //static const String getCommanderById = '/api/v1/commanders/';
}
