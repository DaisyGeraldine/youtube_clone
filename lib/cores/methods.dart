import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/features/upload/long_video/video_details_page.dart';

void showErrorSnackBar(String message, BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

Future pickVideo(BuildContext context) async {
  XFile? file = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
    maxDuration: const Duration(seconds: 60),
  );
  File video = File(file!.path);
  // ignore: use_build_context_synchronously
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return VideoDetailsPage(video: video);
  }));
}

Future pickShortVideo(BuildContext context) async {
  XFile? file = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
    maxDuration: const Duration(seconds: 60),
  );
  File video = File(file!.path);
  // ignore: use_build_context_synchronously
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return VideoDetailsPage(video: video);
  }));
}

Future<File?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (file == null) {
    return null;
  }
  File image = File(file!.path);
  return image;
}

Future<String> putFileInStorage(File? file, String number, String fileType) async {
  final ref = FirebaseStorage.instance.ref().child('$fileType/$number');
  final upload = ref.putFile(file!);

  final snapshot = await upload;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
