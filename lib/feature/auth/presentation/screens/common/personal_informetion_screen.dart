import 'package:flutter/material.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/auth/domain/common/singleton/user_profile_service.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';
import 'description_screen.dart';

class PersonalInformetionScreen extends StatefulWidget {
  final String? userRole;

  const PersonalInformetionScreen({super.key, required this.userRole});

  @override
  State<PersonalInformetionScreen> createState() => UserSignupScreenState();
}

class UserSignupScreenState extends State<PersonalInformetionScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameNameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();

  String? selectedGender;
  String? selectedNationality;
  bool isEditing = true;

  final _formKey = GlobalKey<FormState>();

  final uniqueCountryNames = countries.map((c) => c.country).toSet().toList();

  @override
  void initState() {
    _firstNameController =
        TextEditingController()..addListener(_onFieldChanged);
    _lastNameController = TextEditingController()..addListener(_onFieldChanged);
    _ageController = TextEditingController()..addListener(_onFieldChanged);
    super.initState();
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
    return Validators.name(_firstNameController.text) == null &&
        Validators.name(_lastNameController.text) == null &&
        Validators.age(_ageController.text) == null &&
        selectedGender != null &&
        selectedNationality != null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Personal Information',
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
                        'To create your new account, provide your information.'
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
                          items: ['Male', 'Female', 'Other'],
                          onChanged:
                              (val) => setState(() => selectedGender = val),
                          validator:
                              (value) =>
                                  value == null ? 'Please select gender' : null,
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          label: 'Nationality',
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
              if (_formKey.currentState!.validate()) {
                UserProfileService.instance.profile.firstName =
                    _firstNameController.text;
                UserProfileService.instance.profile.lastName =
                    _lastNameController.text;
                UserProfileService.instance.profile.age = int.tryParse(
                  _ageController.text,
                );
                UserProfileService.instance.profile.gender = selectedGender;
                UserProfileService.instance.profile.nationality =
                    selectedNationality;

                print(
                  'The user data is \n' +
                      '\nFirst name:' +
                      (UserProfileService.instance.profile.firstName ?? '') +
                      '\nLast name:' +
                      (UserProfileService.instance.profile.lastName ?? '') +
                      '\nAge:' +
                      ((UserProfileService.instance.profile.age?.toString()) ??
                          '') +
                      '\nGender:' +
                      (UserProfileService.instance.profile.gender ?? '') +
                      '\nNationality:' +
                      (UserProfileService.instance.profile.nationality ?? ''),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => DescriptionScreen(userRole: widget.userRole),
                  ),
                );
              }
            },
            text: "Continue",
            backgroundColor:
                isFormValid
                    ? AppColors.context(context).primaryColor
                    : AppColors.secondaryColor,
          ),
          const SizedBox(height: 36),
        ],
      ),
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
