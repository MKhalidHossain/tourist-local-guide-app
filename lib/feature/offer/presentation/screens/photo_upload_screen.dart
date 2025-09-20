import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'photo_preview_screen.dart';

class PhotoUploadScreen extends StatefulWidget {
  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File?> uploadedImages = [null, null, null, null]; // 4 slots

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackButton(color: Colors.black),
                SizedBox(width: 10),
                "\nProvide photos of\nyour service".text22Black700(),
                // Text(
                //   "\nProvide photos of\nyour service",
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.w700,
                //     color: Colors.black,
                //   ),
                // ),
                SizedBox(width: 50),
              ],
            ),

            const SizedBox(height: 40),
            // /// Title
            // const Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       'Provide photos of\nyour service',
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black,
            //         height: 1.2,
            //       ),
            //     ),
            //   ),
            // ),

            /// Image Slots (Horizontal)
            SizedBox(
              height: size.width * 0.23,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (uploadedImages[index] == null) {
                        _pickImage(index);
                      }
                    },
                    child: Container(
                      width: size.width * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                        color: Colors.grey[100],
                      ),
                      child:
                          uploadedImages[index] != null
                              ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      uploadedImages[index]!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 6,
                                    top: 6,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          uploadedImages[index] = null;
                                        });
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    left: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        "Image ${index + 1}.jpg",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Image ${index + 1}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            /// Next Button
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      uploadedImages.any((image) => image != null)
                          ? () {
                            Get.to(
                              () => PhotoPreviewScreen(
                                images:
                                    uploadedImages.whereType<File>()
                                    .map((file) => XFile(file.path))
                                    .toList(),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        uploadedImages[index] = File(pickedFile.path);
      });
    }
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'photo_preview_screen.dart';

// class PhotoUploadScreen extends StatefulWidget {
//   @override
//   _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
// }

// class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<File?> uploadedImages = [null, null, null, null]; // 4 slots

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const BackButton(color: Colors.black),
//                 const Text(
//                   "Sport",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(width: 50),
//               ],
//             ),

//             /// Title
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: const Text(
//                   'Provide photos of\nyour service',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     height: 1.2,
//                   ),
//                 ),
//               ),
//             ),

//             /// Grid
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 1.0,
//                   ),
//                   itemCount: 4,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () => _pickImage(index),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey[300]!),
//                         ),
//                         child:
//                             uploadedImages[index] != null
//                                 ? Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(12),
//                                       child: Image.file(
//                                         uploadedImages[index]!,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     Positioned(
//                                       bottom: 8,
//                                       left: 8,
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                           vertical: 4,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.black.withOpacity(0.7),
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           'Image ${index + 1}',
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                                 : Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       width: 40,
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: const Icon(
//                                         Icons.add,
//                                         color: Colors.white,
//                                         size: 24,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       'Image ${index + 1}',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),

//             /// Next Button
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed:
//                       uploadedImages.any((image) => image != null)
//                           ? () => Get.to(
//                             () => PhotoPreviewScreen(
//                               images: uploadedImages.whereType<File>().toList(),
//                             ),
//                           )
//                           : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     disabledBackgroundColor: Colors.grey[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Next',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage(int index) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         uploadedImages[index] = File(pickedFile.path);
//       });
//     }
//   }
// }
