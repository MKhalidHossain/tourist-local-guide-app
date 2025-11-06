import 'package:flutter/material.dart';
import '../../../domain/model/service_data.dart';
import 'photo_upload_screen.dart';

class TimeSettingSportScreen extends StatefulWidget {
  @override
  _TimeSettingSportScreenState createState() => _TimeSettingSportScreenState();
}

class _TimeSettingSportScreenState extends State<TimeSettingSportScreen> {
  final ServiceData serviceData = ServiceData();
  String? selectedTime;

  final List<TimeOption> timeOptions = [
    TimeOption('1 hour', 'Gym for women', Icons.fitness_center, '1_hour_gym'),
    TimeOption('2 hour', 'Large session', Icons.schedule, '2_hour_large'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Time', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Set your time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: timeOptions.length,
              itemBuilder: (context, index) {
                final timeOption = timeOptions[index];
                final isSelected = selectedTime == timeOption.value;
                
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = timeOption.value;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: Offset(0, 2))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.red.withOpacity(0.1) : Colors.grey[100],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(timeOption.icon, size: 24, color: isSelected ? Colors.red : Colors.grey[600]),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: timeOption.duration,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isSelected ? Colors.red : Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' - ${timeOption.description}',
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                            child: Icon(Icons.info_outline, size: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedTime != null
                    ? () {
                        // Save selected time
                        serviceData.selectedTime = selectedTime;
                        serviceData.printData(); // Debug print
                        
                        // Go to next screen
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoUploadScreen()));
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeOption {
  final String duration;
  final String description;
  final IconData icon;
  final String value;
  TimeOption(this.duration, this.description, this.icon, this.value);
}








// import 'package:flutter/material.dart';

// import '../../domain/model/time_option.dart';
// import 'time_setting_photography_screen.dart';

// class TimeSettingSportScreen extends StatefulWidget {
//   @override
//   _TimeSettingSportScreenState createState() => _TimeSettingSportScreenState();
// }

// class _TimeSettingSportScreenState extends State<TimeSettingSportScreen> {
//   String? selectedTime;

//   final List<TimeOption> timeOptions = [
//     TimeOption(
//       '1 hour',
//       'Gym for women',
//       Icons.fitness_center,
//       '1_hour_gym',
//     ),
//     TimeOption(
//       '2 hour',
//       'Large session',
//       Icons.schedule,
//       '2_hour_large',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Time',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Set your time',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               itemCount: timeOptions.length,
//               itemBuilder: (context, index) {
//                 final timeOption = timeOptions[index];
//                 final isSelected = selectedTime == timeOption.value;
                
//                 return Container(
//                   margin: EdgeInsets.only(bottom: 12),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedTime = timeOption.value;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: isSelected ? Colors.red : Colors.grey[300]!,
//                           width: isSelected ? 2 : 1,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 5,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 48,
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: isSelected ? Colors.red.withOpacity(0.1) : Colors.grey[100],
//                               borderRadius: BorderRadius.circular(24),
//                             ),
//                             child: Icon(
//                               timeOption.icon,
//                               size: 24,
//                               color: isSelected ? Colors.red : Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: timeOption.duration,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: isSelected ? Colors.red : Colors.black,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: ' - ${timeOption.description}',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 20,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.info_outline,
//                               size: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(20),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: selectedTime != null
//                     ? () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Sport service time set successfully!'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       }
//                     : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   disabledBackgroundColor: Colors.grey[300],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Next',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
