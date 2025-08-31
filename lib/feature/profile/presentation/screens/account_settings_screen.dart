import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/feature/profile/presentation/screens/common/update_about_me_screen.dart';
import '../../../../core/widgets/app_scaffold.dart';
import 'common/change_password_from_profile_screen.dart';
import 'common/update_personal_informetion_screen.dart';
import 'common/update_spoken_language_screen_profile.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.person,
                text: "Personal Information",
                onTap: () {
                  Get.to(UpdatePersonalInformetionScreen(userRole: 'tourist'));
                },
              ),
              _buildMenuItem(
                icon: Icons.document_scanner_outlined,
                text: "About Me",
                onTap: () {
                  Get.to(UpdateAboutMeScreenProfile());
                },
              ),
              _buildMenuItem(
                icon: Icons.language_outlined,
                text: "Spoken Language",
                onTap: () {
                  Get.to(UpdateSpokenLanguageScreen(userRole: 'tourist'));
                },
              ),
              _buildMenuItem(
                icon: Icons.lock_outline_rounded,
                text: "Change Password",
                onTap: () {
                  Get.to(
                    ChangePasswordFromProfileScreen(
                      userEmail: 'compilefiller@gmail.com',
                    ),
                  );
                },
              ),

              // _buildMenuItem(
              //   icon: Icons.logout,
              //   text: "Log Out",
              //   iconColor: Colors.red,
              //   textColor: Colors.red,
              //   showTrailing: true,
              //   onTap: () {
              //     // Implement logout logic here
              //   },
              // ),
            ],
          ),
        ),
      ),
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
