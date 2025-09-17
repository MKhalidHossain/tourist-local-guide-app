import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../auth/domain/common/singleton/user_profile_service.dart';
import 'screens/photo_upload_screen.dart';
import 'package:kobeur/feature/offer/domain/model/service_data.dart';

class DetailsOfferLocal extends StatefulWidget {
  const DetailsOfferLocal({super.key});

  @override
  State<DetailsOfferLocal> createState() => _DetailsOfferLocalState();
}

class _DetailsOfferLocalState extends State<DetailsOfferLocal> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  //String? selectedGender;
  //String? selectedNationality;
  bool isEditing = true;

  final _formKey = GlobalKey<FormState>();
  ServiceData serviceData = ServiceData();

  @override
  void initState() {
    _titleController = TextEditingController()..addListener(_onFieldChanged);
    _descriptionController =
        TextEditingController()..addListener(_onFieldChanged);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  // void _onFieldChangedDescription() {
  //   setState(() {});
  // }

  bool get isFormValid {
    return Validators.textLength(_descriptionController.text) == null &&
        Validators.textLength(_titleController.text) == null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Details your Offer',
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
        crossAxisAlignment: CrossAxisAlignment.start,

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

                      "Title".text16Black(),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _titleController,
                        focusNode: _titleFocus,
                        keyboardType: TextInputType.text,
                        textCapitalization:
                            TextCapitalization.sentences, // 👈 This line
                        maxLines: 1,
                        //minLines: 1,
                        maxLength: 60,
                        buildCounter: (
                          BuildContext context, {
                          required int currentLength,
                          required bool isFocused,
                          required int? maxLength,
                        }) {
                          return null; // Hide default counter
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your title...',
                          filled: true,
                          fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ).copyWith(bottom: 32),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${60 - _titleController.text.length}' +
                                ' ' +
                                'characters left',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      "Description".text16Black(),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 8,
                        maxLength: 300,
                        buildCounter: (
                          BuildContext context, {
                          required int currentLength,
                          required bool isFocused,
                          required int? maxLength,
                        }) {
                          return null; // Hide default counter
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your description here...',
                          filled: true,
                          fillColor: const Color(0xffC4C4C4).withOpacity(0.25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ).copyWith(bottom: 32),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${300 - _descriptionController.text.length}' +
                                ' ' +
                                'characters left',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
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
                serviceData.userGivenOfferTitle = _titleController.text;
                serviceData.userGivenOfferDescription =
                    _descriptionController.text;
                serviceData.printData();
                Get.to(PhotoUploadScreen());
                //Get.to(UploadProfilePicture());
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
}
