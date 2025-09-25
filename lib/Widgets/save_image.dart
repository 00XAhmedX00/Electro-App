import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> pickAndSaveImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return null;

  final imageFile = File(pickedFile.path);
  final directory = await getApplicationDocumentsDirectory();
  final folderPath = "${directory.path}/app/products";
  await Directory(folderPath).create(recursive: true);

  final fileName = basename(imageFile.path);
  final savedImage = await imageFile.copy("$folderPath/$fileName");

  return savedImage;
}
