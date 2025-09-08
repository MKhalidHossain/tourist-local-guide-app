import 'package:flutter/material.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/formatTripDateText.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String country;
  final String imageUrl;
  final String category;
  final String dateTime;
  final String people;
  final String price;
  final Widget? actionButton;

  const BookingCard({
    super.key,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.category,
    required this.dateTime,
    required this.people,
    required this.price,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(radius: 20, backgroundImage: AssetImage(imageUrl)),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child:
                        (imageUrl.isNotEmpty && (imageUrl != 'null' ?? false))
                            ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/profileBlankImage.png',
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                );
                              },
                            )
                            : Image.asset(
                              'assets/images/profileBlankImage.png',
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [name.text16Black600(), country.text14Grey()],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    category.text14Black600(),
                    const SizedBox(height: 4),
                    price.text16LightRed(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.primaryTextBlack,
                ),
                const SizedBox(width: 8),
                FormatTripDateText(dateStr: dateTime),
                // dateTime.text14Black(),
                const Spacer(),
                Icon(
                  Icons.people_outline,
                  size: 16,
                  color: AppColors.primaryTextBlack,
                ),
                const SizedBox(width: 6),
                people.text14Black(),
              ],
            ),
            if (actionButton != null) ...[
              const SizedBox(height: 12),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}




  // String formatTripDate(String? dateStr) {
  //   if (dateStr == null || dateStr.isEmpty) {
  //     return "0:00 AM, 00/00/00";
  //   }

  //   try {
  //     DateTime parsedDate = DateTime.parse(dateStr);
  //     String formattedDate = DateFormat(
  //       "h:mm a, dd/MM/yy",
  //     ).format(parsedDate.toLocal());
  //     return formattedDate;
  //   } catch (e) {
  //     return "0:00 AM, 00/00/00";
  //   }
  // }