import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/widgets/wide_custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  // THis is work but do code in different formate

  // void _launchEmail() async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'contact@thatchr.app',
  //     queryParameters: {
  //       'subject': 'Help and Support Request',
  //       'body': 'Please describe your issue or question here.',
  //     },
  //   );

  //   try {
  //     if (await canLaunchUrl(emailLaunchUri)) {
  //       await launchUrl(emailLaunchUri);
  //     } else {
  //       Get.snackbar("Failed", 'No email app found on your device.');
  //     }
  //   } catch (e) {
  //     Get.snackbar("Failed", 'Failed to open email app: $e');
  //   }
  // }

  void _launchEmail(BuildContext context) async {
    // Manually construct the mailto URI with proper encoding
    final String email = 'contact@thatchr.app';
    final String subject = Uri.encodeQueryComponent('Help and Support Request');
    final String body = Uri.encodeQueryComponent(
      'Please describe your issue or question here.',
    );
    final String mailtoUri = 'mailto:$email?subject=$subject&body=$body';

    final Uri emailLaunchUri = Uri.parse(mailtoUri);

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        Get.snackbar("Failed", 'No email app found on your device.');
      }
    } catch (e) {
      Get.snackbar("Failed", 'Failed to open email app: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(color: Colors.black),
                  'Help and Support'.text22Black700(),
                  SizedBox(width: 50),
                ],
              ),
              const Text(
                "If you need help or have any questions about your tour, our support team is ready to help you.\n\nSend an email to ",
                style: TextStyle(fontSize: 14),
              ),
              GestureDetector(
                onTap: () => _launchEmail(context),
                child: const Text(
                  "contact@thatchr.app",
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              WideCustomButton(text: 'Submit', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
