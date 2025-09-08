import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:kobeur/feature/profile/presentation/screens/common/about_app_screen.dart';
import '../../../auth/controllers/auth_controller.dart';
import 'account_settings_screen.dart';
import 'common/help_support_screen.dart';
import 'common/privacy_policy_screen.dart';
import 'common/terms_condition_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
  AuthController authController = Get.find<AuthController>();

  bool isLoading = true;
  String? userRole;

  @override
  void initState() {
    profileController = Get.find<ProfileController>();
    profileController.getUserProfile();
    super.initState();
    // Get.find<ProfileController>().getUserProfile();
  }

  // void _loadUserProfile() async {
  //   await profileController.getUserProfile();
  //   userRole = profileController.getProfileResponseModel?.data?.role;
  //   print('User Role: $userRole');
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(
      "===============================user name : ${profileController.getProfileResponseModel?.data?.firstName}",
    );
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return profileController.isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // const SizedBox(height: 24),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     radius: 30,
                      //     backgroundImage: NetworkImage(
                      //       "https://randomuser.me/api/portraits/women/44.jpg",
                      //     ),
                      //   ),
                      //   title: const Text(
                      //     'Kristin Watson',
                      //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      //   ),
                      //   subtitle: const Text('Tourist'),
                      // ),
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey[200],
                                child: Obx(
                                  () => ClipOval(
                                    child:
                                        (profileController.image.value !=
                                                    null &&
                                                (profileController
                                                        .getProfileResponseModel
                                                        ?.data
                                                        ?.profileImage
                                                        ?.isNotEmpty ??
                                                    false))
                                            ? Image.network(
                                              profileController.image.value,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Image.asset(
                                                  'assets/images/profileBlankImage.png',
                                                  fit: BoxFit.cover,
                                                  width: 70,
                                                  height: 70,
                                                );
                                              },
                                            )
                                            : Image.asset(
                                              'assets/images/profileBlankImage.png',
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                            ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 0,
                                right: -2,
                                child: GestureDetector(
                                  onTap: () {
                                    // Handle image change
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  " ${profileController.name.value ?? 'No Name'}"
                                      .text20Grey700(),
                                  "${profileController.nationality.value ?? 'Nationality'}"
                                      .text16Grey(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildMenuItem(
                        icon: Icons.settings,
                        text: "Account Settings",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AccountSettingsScreen(),
                            ),
                          );
                        },
                      ),

                      _buildMenuItem(
                        icon: Icons.info_outline,
                        text: "About App",
                        onTap: () {
                          Get.to(AboutAppScreen());
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.privacy_tip_outlined,
                        text: "Privacy Policy",
                        onTap: () {
                          Get.to(PrivacyPolicyScreen());
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.article_outlined,
                        text: "Term & Condition",
                        onTap: () {
                          Get.to(TermsConditionScreen());
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.help_outline,
                        text: "Help & Support",
                        onTap: () {
                          Get.to(HelpSupportScreen());
                        },
                      ),

                      _buildMenuItem(
                        icon: Icons.logout,
                        text: "Log Out",
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        showTrailing: true,
                        onTap: () async {
                          await Get.find<AuthController>().logOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
    Color iconColor = const Color(0xff666666),
    Color textColor = const Color(0xff666666),
    bool showTrailing = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            onTap: onTap,
            dense: true,
            leading: Icon(icon, color: iconColor),
            title: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
            trailing:
                showTrailing
                    ? Icon(Icons.arrow_forward_ios, size: 16, color: iconColor)
                    : null,
          ),
        ),
        Divider(height: 0.5, thickness: 0.5, color: textColor),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
// import 'package:kobeur/feature/profile/presentation/screens/common/about_app_screen.dart';
// import '../../../auth/controllers/auth_controller.dart';
// import 'account_settings_screen.dart';
// import 'common/help_support_screen.dart';
// import 'common/privacy_policy_screen.dart';
// import 'common/terms_condition_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {

//   ProfileController profileController = Get.find<ProfileController>();
//   AuthController authController = Get.find<AuthController>();

//   bool isLoading = true;
//   String? userRole;

//   @override
//   void initState() {
//     profileController.getUserProfile();
//     super.initState();
//     // Get.find<ProfileController>().getUserProfile();
//   }

//   // void _loadUserProfile() async {
//   //   await profileController.getUserProfile();
//   //   userRole = profileController.getProfileResponseModel?.data?.role;
//   //   print('User Role: $userRole');
//   //   setState(() {
//   //     isLoading = false;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     print("===============================user name : ${profileController.getProfileResponseModel?.data?.firstName}");
//     return GetBuilder<ProfileController>(
//       builder: (profileController) {
//         return profileController.isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Scaffold(
//               backgroundColor: Colors.white,
//               body: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       // const SizedBox(height: 24),
//                       // ListTile(
//                       //   leading: CircleAvatar(
//                       //     radius: 30,
//                       //     backgroundImage: NetworkImage(
//                       //       "https://randomuser.me/api/portraits/women/44.jpg",
//                       //     ),
//                       //   ),
//                       //   title: const Text(
//                       //     'Kristin Watson',
//                       //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       //   ),
//                       //   subtitle: const Text('Tourist'),
//                       // ),
//                       Row(
//                         children: [
//                           Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               CircleAvatar(
//                                 radius: 35,
//                                 backgroundColor: Colors.grey[200],
//                                 child: ClipOval(
//                                   child:
//                                       (profileController.getProfileResponseModel?.data?.profileImage!= null &&
//                                               (profileController
//                                                     .getProfileResponseModel
//                                                     ?.data
//                                                     ?.profileImage
//                                                     ?.isNotEmpty ??
//                                                 false))
//                                           ? Image.network(
//                                             profileController.getProfileResponseModel?.data?.profileImage ?? 'No Image',
//                                             fit: BoxFit.cover,
//                                             width: 70,
//                                             height: 70,
//                                             errorBuilder: (
//                                               context,
//                                               error,
//                                               stackTrace,
//                                             ) {
//                                               return Image.asset(
//                                                 'assets/images/profileBlankImage.png',
//                                                 fit: BoxFit.cover,
//                                                 width: 70,
//                                                 height: 70,
//                                               );
//                                             },
//                                           )
//                                           : Image.asset(
//                                             'assets/images/profileBlankImage.png',
//                                             fit: BoxFit.cover,
//                                             width: 70,
//                                             height: 70,
//                                           ),
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: -2,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     // Handle image change
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.all(4),
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.red,
//                                     ),
//                                     child: const Icon(
//                                       Icons.camera_alt,
//                                       size: 14,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 " ${profileController.getProfileResponseModel?.data?.firstName ?? 'No'} ${profileController.getProfileResponseModel?.data?.lastName ?? 'Name'}"
//                                     .text20Grey700(),
//                                 "${profileController.getProfileResponseModel?.data?.nationality ?? 'Nationality'}".text16Grey(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       _buildMenuItem(
//                         icon: Icons.settings,
//                         text: "Account Settings",
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const AccountSettingsScreen(),
//                             ),
//                           );
//                         },
//                       ),

//                       _buildMenuItem(
//                         icon: Icons.info_outline,
//                         text: "About App",
//                         onTap: () {
//                           Get.to(AboutAppScreen());
//                         },
//                       ),
//                       _buildMenuItem(
//                         icon: Icons.privacy_tip_outlined,
//                         text: "Privacy Policy",
//                         onTap: () {
//                           Get.to(PrivacyPolicyScreen());
//                         },
//                       ),
//                       _buildMenuItem(
//                         icon: Icons.article_outlined,
//                         text: "Term & Condition",
//                         onTap: () {
//                           Get.to(TermsConditionScreen());
//                         },
//                       ),
//                       _buildMenuItem(
//                         icon: Icons.help_outline,
//                         text: "Help & Support",
//                         onTap: () {
//                           Get.to(HelpSupportScreen());
//                         },
//                       ),

//                       _buildMenuItem(
//                         icon: Icons.logout,
//                         text: "Log Out",
//                         iconColor: Colors.red,
//                         textColor: Colors.red,
//                         showTrailing: true,
//                         onTap: () async {
//                           await Get.find<AuthController>().logOut();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//       },
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String text,
//     VoidCallback? onTap,
//     Color iconColor = const Color(0xff666666),
//     Color textColor = const Color(0xff666666),
//     bool showTrailing = true,
//   }) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0),
//           child: ListTile(
//             onTap: onTap,
//             dense: true,
//             leading: Icon(icon, color: iconColor),
//             title: Text(
//               text,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//             trailing:
//                 showTrailing
//                     ? Icon(Icons.arrow_forward_ios, size: 16, color: iconColor)
//                     : null,
//           ),
//         ),
//         Divider(height: 0.5, thickness: 0.5, color: textColor),
//       ],
//     );
//   }
// }
