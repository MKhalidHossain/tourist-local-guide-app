import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/constants/app_colors.dart';
import 'package:kobeur/feature/auth/domain/common/singleton/user_profile_service.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/choose_country/data/countries.dart';
import 'upload_profile_picture.dart';

class DescriptionScreen extends StatefulWidget {
  final String? userRole;

  const DescriptionScreen({super.key, required this.userRole});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late TextEditingController _descriptionController;

  final FocusNode _descriptionFocus = FocusNode();
  bool isEditing = true;
  final _formKey = GlobalKey<FormState>();

  final uniqueCountryNames = countries.map((c) => c.country).toSet().toList();

  @override
  void initState() {
    _descriptionController =
        TextEditingController()..addListener(_onFieldChanged);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();

    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get isFormValid {
    return Validators.textLength(
          minLength: 3,
          maxLength: 600,
          _descriptionController.text,
        ) ==
        null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'About Me',
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
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Stack(
                        children: [
                          TextFormField(
                            controller: _descriptionController,
                            focusNode: _descriptionFocus,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            minLines: 8,
                            maxLength: 600,
                            buildCounter: (
                              BuildContext context, {
                              required int currentLength,
                              required bool isFocused,
                              required int? maxLength,
                            }) {
                              return null; // Hide default counter
                            },
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write your description here...',
                              filled: true,
                              fillColor: const Color(
                                0xffC4C4C4,
                              ).withOpacity(0.25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ).copyWith(bottom: 48),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                          ),
                          Positioned(
                            bottom: 8,
                            right: 12,
                            child: Text(
                              '${_descriptionController.text.length}/600',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // TextFormField(
                      //   controller: _descriptionController,
                      //   focusNode: _descriptionFocus,
                      //   keyboardType: TextInputType.text,
                      //   validator: Validators.textLength,
                      //   decoration: InputDecoration(
                      //     hintText: 'Write your about here. . .',
                      //     hintStyle: TextStyle(
                      //       color: AppColors.secondayText,
                      //     ),
                      //     filled: true,
                      //     fillColor: const Color(
                      //       0xffC4C4C4,
                      //     ).withOpacity(0.25),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //   ),
                      //   style: TextStyle(
                      //     color: AppColors.secondayText,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
          context.primaryButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                UserProfileService.instance.profile.description =
                    _descriptionController.text;
                print(
                  '\nThe description is:' +
                      '${UserProfileService.instance.profile.description}',
                );
                await Future.delayed(Duration(seconds: 1));
                Get.to(UploadProfilePicture(userRole: widget.userRole));
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          dropdownColor: const Color(0xffC4C4C4),
          style: const TextStyle(color: Colors.black, fontSize: 16),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
