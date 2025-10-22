import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';

class UpdatePersonalInformetionScreen extends StatefulWidget {
  final String? userRole;

  const UpdatePersonalInformetionScreen({super.key, required this.userRole});

  @override
  State<UpdatePersonalInformetionScreen> createState() =>
      UserSignupScreenState();
}

class UserSignupScreenState extends State<UpdatePersonalInformetionScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameNameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  late ProfileController profileController;
  String? selectedGender;
  String? selectedNationality;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> updatedFields = {};
  final uniqueCountryNames = countries.map((c) => c.country).toSet().toList();

  String? _findMatchingCountry(String? nationality) {
    if (nationality == null || nationality.isEmpty) return null;
    final match = uniqueCountryNames.firstWhere(
      (country) =>
          country.toLowerCase().contains(nationality.toLowerCase()) ||
          nationality.toLowerCase().contains(country.toLowerCase()),
      orElse: () => '',
    );
    return match.isNotEmpty ? match : null;
  }

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.getUserProfile();
      final profileData = profileController.getProfileResponseModel?.data;
      setState(() {
        _firstNameController = TextEditingController(text: profileData?.firstName ?? '')
          ..addListener(_onFieldChanged);
        _lastNameController = TextEditingController(text: profileData?.lastName ?? '')
          ..addListener(_onFieldChanged);
        _ageController = TextEditingController(text: profileData?.age?.toString() ?? '')
          ..addListener(_onFieldChanged);
        selectedGender = profileData?.gender?.isNotEmpty == true ? profileData!.gender : null;
        selectedNationality = profileData?.nationality?.isNotEmpty == true
            ? _findMatchingCountry(profileData!.nationality)
            : null;
      });
      print('Initial Values: firstName=${_firstNameController.text}, '
          'lastName=${_lastNameController.text}, age=${_ageController.text}, '
          'gender=$selectedGender, nationality=$selectedNationality');
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get isFormValid {
    final profileData = profileController.getProfileResponseModel?.data;
    if (profileData == null) {
      print('isFormValid: profileData is null');
      return false;
    }

    // Current values
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final age = _ageController.text.trim();
    final gender = selectedGender;
    final nationality = selectedNationality;

    // Validate required fields (not null/empty + pass validator)
    final isFirstNameValid =
        firstName.isNotEmpty && Validators.name(firstName) == null;
    final isLastNameValid =
        lastName.isNotEmpty && Validators.name(lastName) == null;
    final isAgeValid = age.isNotEmpty && Validators.age(age) == null;
    final isGenderValid = gender != null && gender.isNotEmpty;
    final isNationalityValid = nationality != null && nationality.isNotEmpty;

    // Check if all fields are valid
    final allValid = isFirstNameValid &&
        isLastNameValid &&
        isAgeValid &&
        isGenderValid &&
        isNationalityValid;

    // Check if any field has changed
    final hasChanges = firstName != (profileData.firstName ?? '') ||
        lastName != (profileData.lastName ?? '') ||
        age != (profileData.age?.toString() ?? '') ||
        gender != (profileData.gender ?? '') ||
        nationality != (profileData.nationality ?? '');

    print('isFormValid: allValid=$allValid, hasChanges=$hasChanges');
    print('Field Values: firstName=$firstName (original: ${profileData.firstName}), '
        'lastName=$lastName (original: ${profileData.lastName}), '
        'age=$age (original: ${profileData.age}), '
        'gender=$gender (original: ${profileData.gender}), '
        'nationality=$nationality (original: ${profileData.nationality})');

    return allValid && hasChanges;
  }

  void savePersonalUpdatedInformetion() async {
    if (_formKey.currentState!.validate() && isFormValid) {
      final profileData = profileController.getProfileResponseModel?.data;
      updatedFields.clear();
      if (_firstNameController.text.trim() != (profileData?.firstName ?? '')) {
        updatedFields['firstName'] = _firstNameController.text.trim();
      }
      if (_lastNameController.text.trim() != (profileData?.lastName ?? '')) {
        updatedFields['lastName'] = _lastNameController.text.trim();
      }
      if (_ageController.text.trim() != (profileData?.age?.toString() ?? '')) {
        updatedFields['age'] = int.tryParse(_ageController.text.trim());
      }
      if (selectedGender != (profileData?.gender ?? '')) {
        updatedFields['gender'] = selectedGender;
      }
      if (selectedNationality != (profileData?.nationality ?? '')) {
        updatedFields['nationality'] = selectedNationality;
      }

      if (updatedFields.isEmpty) {
        Get.snackbar("No Changes", "You didn’t update any information.");
        return;
      }

      print("✅ Updated fields: $updatedFields");
      await profileController.updateSpacificFieldUserProfile(
        firstName: updatedFields['firstName'],
        lastName: updatedFields['lastName'],
        age: updatedFields['age'],
        gender: updatedFields['gender'],
        nationality: updatedFields['nationality'],
      );

      Get.off(() => UpdatePersonalInformetionScreen(userRole: widget.userRole));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return AppScaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () => Get.back(),
            ),
            title: const Text(
              'Update Personal Information',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                wordSpacing: 2,
              ),
            ),
            centerTitle: false,
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: size.height),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'To update your account, provide your information.'
                                .text14Black(),
                            const SizedBox(height: 24),
                            _buildCustomTextField(
                              title: 'First Name',
                              context: context,
                              label: 'Write your first name here',
                              controller: _firstNameController,
                              focusNode: _firstNameFocus,
                              validator: Validators.name,
                            ),
                            _buildCustomTextField(
                              title: 'Last Name',
                              context: context,
                              label: 'Write your last name here',
                              controller: _lastNameController,
                              focusNode: _lastNameNameFocus,
                              validator: Validators.name,
                            ),
                            _buildCustomTextField(
                              title: 'Age',
                              context: context,
                              label: 'Write your age here',
                              controller: _ageController,
                              focusNode: _ageFocus,
                              validator: Validators.age,
                              keyboardType: TextInputType.number,
                            ),
                            _buildDropdown(
                              label: 'Gender',
                              value: selectedGender,
                              items: ['male', 'female', 'other'],
                              onChanged: (val) =>
                                  setState(() => selectedGender = val),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select gender'
                                      : null,
                            ),
                            const SizedBox(height: 12),
                            _buildDropdown(
                              label: 'Nationality',
                              value: selectedNationality,
                              items: uniqueCountryNames,
                              onChanged: (val) =>
                                  setState(() => selectedNationality = val),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select nationality'
                                      : null,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              context.primaryButton(
                onPressed: isFormValid ? savePersonalUpdatedInformetion : () {},
                text: "Save",
                backgroundColor: isFormValid
                    ? AppColors.context(context).primaryColor
                    : AppColors.secondaryColor,
              ),
              const SizedBox(height: 36),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomTextField({
    required String title,
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: AppColors.secondayText),
            filled: true,
            fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(
            color: AppColors.secondayText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: AppColors.secondayText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
            hintText: 'Select $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondaryColor,
          ),
          dropdownColor: Colors.white.withOpacity(0.9),
          style: const TextStyle(color: AppColors.secondayText, fontSize: 16),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      item,
                      style: const TextStyle(color: AppColors.secondayText),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}