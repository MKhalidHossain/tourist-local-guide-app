class ServiceData {
  static final ServiceData _instance = ServiceData._internal();
  factory ServiceData() => _instance;
  ServiceData._internal();

  // All service data in one place
  String? selectedCategory;
  String? selectedOffer;
  String? selectedTime;
  List<String> uploadedPhotos = [];
  List<DateTime> selectedDates = [];
  List<String> selectedTimeSlots = [];

  // Clear all data
  void clear() {
    selectedCategory = null;
    selectedOffer = null;
    selectedTime = null;
    uploadedPhotos.clear();
    selectedDates.clear();
    selectedTimeSlots.clear();
  }

  // Print current data (for debugging)
  void printData() {
    print('=== Service Data ===');
    print('Category: $selectedCategory');
    print('Offer: $selectedOffer');
    print('Time: $selectedTime');
    print('Photos: ${uploadedPhotos.length}');
    print('Dates: ${selectedDates.length}');
    print('Time Slots: ${selectedTimeSlots.length}');
  }
}
