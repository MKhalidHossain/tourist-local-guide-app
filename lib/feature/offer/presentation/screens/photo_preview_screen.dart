import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'date_selection_screen.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final List<XFile> images;

  const PhotoPreviewScreen({super.key, required this.images});

  @override
  _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  late List<XFile?> uploadedImages;
  XFile? selectedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    uploadedImages = List<XFile?>.from(widget.images);
    while (uploadedImages.length < 4) uploadedImages.add(null);
    selectedImage = uploadedImages.firstWhere(
      (img) => img != null,
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with time and signal
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(color: Colors.black),
                  "Provide photos of\nyour service".text22Black700(),
                  // const Text(

                  //   style: TextStyle(
                  //     fontSize: 22,
                  //     fontWeight: FontWeight.w700,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  const SizedBox(width: 50),
                  // Row(
                  //   children: const [
                  //     Icon(Icons.signal_cellular_alt, size: 16, color: Colors.grey),
                  //     SizedBox(width: 4),
                  //     Icon(Icons.battery_full, size: 16, color: Colors.grey),
                  //     SizedBox(width: 4),
                  //     Text(
                  //       "9:41",
                  //       style: TextStyle(fontSize: 16, color: Colors.grey),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Main Image Preview
            if (selectedImage != null)
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(selectedImage!.path),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            int index = uploadedImages.indexOf(selectedImage);
                            uploadedImages[index] = null;
                            selectedImage = uploadedImages.firstWhere(
                              (img) => img != null,
                              orElse: () => null,
                            );
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            // Thumbnail Images
            Container(
              height: 80,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  ...uploadedImages.asMap().entries.map((entry) {
                    int index = entry.key;
                    XFile? img = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          if (img != null) {
                            setState(() {
                              selectedImage = img;
                            });
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[100],
                            child:
                                img != null
                                    ? Image.file(
                                      File(img.path),
                                      fit: BoxFit.cover,
                                    )
                                    : GestureDetector(
                                      onTap: () => _pickImage(index),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const Spacer(),
            // Next Button
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      uploadedImages.any((img) => img != null)
                          ? () {
                            Get.to(
                              DateSelectionScreen(
                                images:
                                    uploadedImages.whereType<XFile>().toList(),
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
        uploadedImages[index] = pickedFile;
        selectedImage = pickedFile;
      });
    }
  }
}

