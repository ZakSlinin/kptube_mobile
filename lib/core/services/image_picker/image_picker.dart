import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({required ImageSource source}) async {
  try {
    final image = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  } catch (e) {
    print('Error picking image: $e');
    return null;
  }
}

Future<File?> pickImageHeader({required ImageSource source}) async {
  try {
    final avatar = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (avatar != null) {
      return File(avatar.path);
    }
    return null;
  } catch (e) {
    print('Error picking image: $e');
    return null;
  }
}
