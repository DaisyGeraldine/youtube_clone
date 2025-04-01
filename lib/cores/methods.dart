import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

pickVideo() async {
  XFile? file = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
    maxDuration: const Duration(seconds: 60),
  );
  File video = File(file!.path);
  if (file != null) {
    return video;
  }
}

Future<File?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  File image = File(file!.path);
  return image;
}

putFileInStorage(file, number, fileType) async {
  final ref = FirebaseStorage.instance.ref().child('$fileType/$number');
  final upload = ref.putFile(file);
  final snapshot = await upload;
  String downdloadUrl = await snapshot.ref.getDownloadURL();
  return downdloadUrl;
}
