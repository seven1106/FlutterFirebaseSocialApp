import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message),
    ));
}
Future<FilePickerResult?> pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );
  return result;
}

Future<List<XFile>?> pickMultipleImages() async {
  try {
    final pickedImages = await ImagePicker().pickMultiImage();
    return pickedImages;
  } catch (e) {
    return null;
  }
}
Future<XFile?> pickImageCamera() async {
  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedImage;
  } catch (e) {
    return null;
  }
}
// Future<List<File>?> pickVideos() async {
//   try {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.video,
//       allowMultiple: true,
//     );
//
//     if (result == null || result.files.isEmpty) {
//       return null;
//     }
//     List<File> videoFiles = result.files.map((file) => File(file.path!)).toList();
//     return videoFiles;
//   } catch (e) {
//     return null;
//   }
// }



