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
  bool isEditing = true;

  final _formKey = GlobalKey<FormState>();
  // cheak  for data update or not
  final Map<String, dynamic> updatedFields = {};

  final uniqueCountryNames = countries.map((c) => c.country).toSet().toList();

  @override
  void initState() {
    super.initState();

    profileController = Get.find<ProfileController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      profileController.getUserProfile();
      final profileData = profileController.getProfileResponseModel?.data;
      _firstNameController = TextEditingController(text: profileData?.firstName)
        ..addListener(_onFieldChanged);
      _lastNameController = TextEditingController(text: profileData?.lastName)
        ..addListener(_onFieldChanged);
      _ageController = TextEditingController(
        text: (profileData?.age.toString()),
      )..addListener(_onFieldChanged);

      setState(() {});
      print(
        "fristName (initState): ${profileData?.firstName}\n LastName (initState): ${profileData?.lastName}\n Age (initState): ${profileData?.age}\n",
      );
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

  // void savePersonalUpdatedInformetion() async {
  //   if (_formKey.currentState!.validate()) {
  //     await profileController.updateSpacificFieldUserProfile(
  //       firstName:
  //     );
  //     Get.to(() => UpdatePersonalInformetionScreen(userRole: widget.userRole));
  //   }
  // }

  void savePersonalUpdatedInformetion() async {
    if (_formKey.currentState!.validate()) {
      final profileData = profileController.getProfileResponseModel?.data;

      if (_firstNameController.text.trim() != (profileData?.firstName ?? '')) {
        updatedFields['firstName'] = _firstNameController.text.trim();
      }
      if (_lastNameController.text.trim() != (profileData?.lastName ?? '')) {
        updatedFields['lastName'] = _lastNameController.text.trim();
      }
      if (_ageController.text.trim() != (profileData?.age?.toString() ?? '')) {
        updatedFields['age'] = int.tryParse(_ageController.text.trim());
      }
      if (selectedGender != null &&
          selectedGender != (profileData?.gender ?? '')) {
        updatedFields['gender'] = selectedGender;
      }
      if (selectedNationality != null &&
          selectedNationality != (profileData?.nationality ?? '')) {
        updatedFields['nationality'] = selectedNationality;
      }

      // 🟢 Print updated fields
      if (updatedFields.isNotEmpty) {
        print("✅ Updated fields: $updatedFields");
      } else {
        print("ℹ️ No fields updated");
      }

      if (updatedFields.isEmpty) {
        Get.snackbar("No Changes", "You didn’t update any information.");
        return;
      }

      // Call controller with spread operator
      await profileController.updateSpacificFieldUserProfile(
        firstName: updatedFields['firstName'],
        lastName: updatedFields['lastName'],
        age: updatedFields['age'],
        gender: updatedFields['gender'],
        nationality: updatedFields['nationality'],
      );

      Get.to(() => UpdatePersonalInformetionScreen(userRole: widget.userRole));
    }
  }

  // bool get isFormValid {
  //   final profileData = profileController.getProfileResponseModel?.data;
  //   return Validators.name(_firstNameController.text) == null &&
  //           Validators.name(_lastNameController.text) == null &&
  //           Validators.age(_ageController.text) == null &&
  //           selectedGender != null &&
  //           selectedNationality != null ||
  //       _firstNameController.text.trim() != (profileData?.firstName ?? '') ||
  //       _lastNameController.text.trim() != (profileData?.lastName ?? '') ||
  //       _ageController.text.trim() != (profileData?.age.toString() ?? '') ||
  //       selectedGender != profileData?.gender ||
  //       selectedNationality != profileData?.nationality;
  // }

  bool get isFormValid {
    final profileData = profileController.getProfileResponseModel?.data;
    if (profileData == null) return false;

    // ✅ Step 1: check validity
    final isFirstNameValid = Validators.name(_firstNameController.text) == null;
    final isLastNameValid = Validators.name(_lastNameController.text) == null;
    final isAgeValid = Validators.age(_ageController.text) == null;
    final isGenderValid = selectedGender != null;
    final isNationalityValid = selectedNationality != null;

    final allValid =
        isFirstNameValid &&
        isLastNameValid &&
        isAgeValid &&
        isGenderValid &&
        isNationalityValid;

    // ✅ Step 2: check if there are changes
    final hasChanges =
        _firstNameController.text.trim() != (profileData.firstName ?? '') ||
        _lastNameController.text.trim() != (profileData.lastName ?? '') ||
        _ageController.text.trim() != (profileData.age?.toString() ?? '') ||
        selectedGender != profileData.gender ||
        selectedNationality != profileData.nationality;

    // ✅ Step 3: only enable if BOTH are true
    return allValid && hasChanges;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gender = profileController.getProfileResponseModel?.data?.gender;

    // final normalizedGender =
    //     (gender != null)
    //         ? gender[0].toUpperCase() + gender.substring(1).toLowerCase()
    //         : null;

    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return AppScaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
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
                              initialValue: gender,
                              value: selectedGender,
                              items: ['male', 'female', 'other'],
                              onChanged:
                                  (val) => setState(() => selectedGender = val),
                              validator:
                                  (value) =>
                                      value == null
                                          ? 'Please select gender'
                                          : null,
                            ),
                            const SizedBox(height: 12),
                            _buildDropdown(
                              label: 'Nationality',
                              initialValue:
                                  uniqueCountryNames.contains(
                                        profileController
                                            .getProfileResponseModel
                                            ?.data
                                            ?.nationality,
                                      )
                                      ? profileController
                                          .getProfileResponseModel
                                          ?.data
                                          ?.nationality
                                      : null,
                              value: selectedNationality,
                              items: uniqueCountryNames,
                              onChanged:
                                  (val) =>
                                      setState(() => selectedNationality = val),
                              validator:
                                  (value) =>
                                      value == null
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
                onPressed: () {
                  if (_formKey.currentState!.validate() && isFormValid) {
                    savePersonalUpdatedInformetion();
                  }
                },
                text: "Save",
                backgroundColor:
                    isFormValid
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
    String? initialValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            text: label,
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
        DropdownButtonFormField<String>(
          initialValue: initialValue,
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
          dropdownColor: const Color(0xffC4C4C4).withOpacity(0.8),
          style: const TextStyle(color: AppColors.secondayText, fontSize: 16),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.black),
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
