import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    print("Opening ImagePicker...");

    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery,
    );
  

    print("xFile = $xFile");

    if (xFile != null) {
      return File(xFile.path);
    }

    print("User cancelled or picker returned null");
    return null;
  } catch (e) {
    print("IMAGE PICKER ERROR: $e");
    return null;
  }
}
