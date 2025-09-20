import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/auth/domain/common/singleton/user_profile_service.dart';
import 'package:kobeur/navigation/bottom_navigationber_screen.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../offer/presentation/screens/create_first_service_screen.dart';
import '../../../../profile/controllers/profile_controller.dart';

class UploadProfilePicture extends StatefulWidget {
  final String? userRole;

  const UploadProfilePicture({super.key, required this.userRole});
  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _descriptionController;
  final FocusNode _descriptionFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final profileController = Get.find<ProfileController>();
  bool isLoading = true;
  String? userRole;

  @override
  void initState() {
    _descriptionController =
        TextEditingController()..addListener(_onFieldChanged);
    super.initState();

    // profileController.getUserRole();

    isLoading = false;

    // _loadUserProfile(); // fetch profile
  }

  // void _loadUserProfile() async {
  //   isLoading = true;
  //   await profileController.getUserProfile();
  //   userRole = profileController.getProfileResponseModel?.data?.role;
  //   print('User Role: $userRole');
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get isFormValid {
    return Validators.name(_descriptionController.text) == null;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    debugPrint('Picked Image: ${pickedFile?.path}');

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : AppScaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: const Text(
                  'Upload Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                centerTitle: false,
                elevation: 0,
              ),
              body: SafeArea(
                top: false,
                bottom: true,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'To create your new account, provide one of your photos.'
                            .text14Black(),

                        /// Middle content
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child:
                                      _imageFile != null
                                          ? Image.file(
                                            File(_imageFile!.path),
                                            height: size.width * 0.8,
                                            width: size.width * 0.8,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.asset(
                                            'assets/images/profileBlankImage.png',
                                            height: size.width * 0.8,
                                            width: size.width * 0.8,
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed:
                                              () => _pickImage(
                                                ImageSource.camera,
                                              ),
                                        ),
                                        const Text(
                                          'Camera',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.photo_library_outlined,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed:
                                              () async => await _pickImage(
                                                ImageSource.gallery,
                                              ),
                                        ),
                                        const Text(
                                          'Gallery',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 54),
                            ],
                          ),
                        ),

                        /// Bottom buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.45,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (userRole == 'Tourist') {
                                    Get.to(
                                      () => BottomNavbar(userRole: userRole,),
                                    ); // replace with your tourist screen
                                  } else if (userRole == 'Local') {
                                    Get.to(
                                      () => CreateFirstServiceScreen(),
                                    ); // replace with your local screen
                                  } else {
                                    Get.snackbar('Error', 'Unknown user role');
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color:
                                        AppColors.context(context).primaryColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 24,
                                  ),
                                ),
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                    color:
                                        AppColors.context(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            context.primaryButton(
                              onPressed: () async {
                                if (_imageFile == null) {
                                  Get.snackbar(
                                    'Error',
                                    'Please select a profile image',
                                  );
                                  return;
                                }

                                // // Store picked image in singleton
                                // UserProfileService
                                //     .instance
                                //     .profile
                                //     .profileImage = _imageFile;

                                // Get other data from API model
                                final model =
                                    UserProfileService.instance.profile;

                                debugPrint(
                                  'Profile Data: ${model.profileImage?.path ?? 'No image'}',
                                );

                                if (model == null) {
                                  Get.snackbar(
                                    'Error',
                                    'Profile data is missing,   Failed to load profile data\nPlease fill in your profile details first.',
                                  );
                                  return;
                                }

                                // need to conditon this if all things are not null then go to login screen

                                // otehrwise show snackbar and got to filling data screen

                                // Call updateProfile with both API data + new image
                                try {
                                  await profileController.updateUserProfile(
                                    firstName: model.firstName ?? '',
                                    lastName: model.lastName ?? '',
                                    age: model.age ?? 0,
                                    userRole: widget.userRole,
                                    gender: model.gender ?? '',
                                    nationality: model.nationality ?? '',
                                    description: model.description ?? '',
                                    languages: model.languages ?? [],
                                    profileImage: _imageFile ?? XFile(''),
                                  );
                                  // Navigate based on userRole

                                  // Get.offAll(UserLoginScreen());
                                } catch (e, st) {
                                  debugPrint(
                                    " ❌ Error calling updateUserProfile: $e \n$st",
                                  );
                                  Get.snackbar(
                                    "Error",
                                    "Something went wrong while updating your profile. Please try again.",
                                  );
                                }
                              },
                              width: size.width * 0.45,
                              text: "Continue",
                              backgroundColor:
                                  _imageFile != null
                                      ? AppColors.context(context).primaryColor
                                      : AppColors.secondaryColor,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
      },
    );
  }
}
