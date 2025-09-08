import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../chat/tourist/message/presentation/screens/chat_screen.dart';

class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({super.key});

  final instructions = [
    'Bring comfortable walking shoes and weather appropriate clothing.',
    'Your local guide will be wearing a blue badge for easy identification.',
    'Please arrive at the point 5 minutes before the scheduled time.',
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: 'Booking Details'.text24Black(),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Booking:'.text16Black(),
                '# RES-2023-7845'.text16Black(),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Jerome Bell'.text14Black600(),
                      'China'.text14Grey(),
                    ],
                  ),
                ),
                SecondaryButton(
                  width: 110,
                  height: 40,
                  fontSize: 14,
                  text: 'Message',
                  onPressed: () {
                    Get.to(() => ChatScreen());
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            'Experience'.text16Black600(),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'City Tour'.text14Black600(),
                      '\$125.00'.text16LightRed(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.black,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          '9:00 AM, 11/06/25'.text14Black(),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/icons/persons.png', height: 14),
                          const SizedBox(width: 4),
                          '04 People'.text14Black(),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/nanchanTemple.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Nanchan Temple'.text14Black600(),
                              'City Tour'.text14Grey(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffEAB308),
                                        size: 16,
                                      ),
                                      '5(4.8)'.text12Black(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      '\$30'.text16LightRed(),
                                      '/hour'.text12Black(),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            'Important Information'.text16Black600(),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  instructions
                      .map(
                        (text) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '•',
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.4,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  text,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Color(0xFF4D4D4D),
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
            const Spacer(),
            context.primaryButton(
              width: double.infinity,

              text: 'Edit Booking',
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              width: double.infinity,

              text: 'Cancel Booking',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:kobeur/core/common/button/button_widget.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/widgets/app_scaffold.dart';

// class BookingDetailsScreen extends StatelessWidget {
//   const BookingDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: const Text(
//           'Booking Details',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             wordSpacing: 2,
//           ),
//         ),
//         centerTitle: false,
//         elevation: 0,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Booking:',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 '# RES-2023-7845',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage('assets/images/user.png'),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Jerome Bell',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       'China',
//                       style: TextStyle(color: AppColors.secondayText),
//                     ),
//                   ],
//                 ),
//               ),
//               SecondaryButton(
//                 width: 110,
//                 height: 40,
//                 text: 'Message',
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Experience',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w700,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'City Tour',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       '\$125.00',
//                       style: TextStyle(
//                         color: AppColors.context(context).primaryColor,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.calendar_today_outlined,
//                           color: Colors.black,
//                           size: 14,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '9:00 AM, 11/06/25',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Image.asset('assets/icons/persons.png', height: 14),
//                         const SizedBox(width: 4),
//                         Text(
//                           '04 People',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 12),
//                   width: double.infinity,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 110,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           image: const DecorationImage(
//                             image: AssetImage(
//                               'assets/images/nanchanTemple.png',
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Nanchan Temple',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               'City Tour',
//                               style: TextStyle(color: AppColors.secondayText),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: Color(0xffEAB308),
//                                       size: 16,
//                                     ),
//                                     Text(
//                                       '5(4.8)',
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       '\$30',
//                                       style: TextStyle(
//                                         color:
//                                             AppColors.context(
//                                               context,
//                                             ).primaryColor,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       '/hour',
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }