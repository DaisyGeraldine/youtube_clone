import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/upload/long_video/video_repository.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File? video;
  const VideoDetailsPage({super.key, this.video});

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  bool isThumbnailSelected = false;
  String randomNumber = const Uuid().v4();
  String videoId = const Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Details"),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter the title",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Video Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Enter the title of your video',
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Enter the description",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Video Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Enter the description of your video',
                  prefixIcon: Icon(Icons.description),
                ),
              ),

              // select thumbnail

              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(11),
                      )),
                  child: TextButton(
                    onPressed: () async {
                      // pick image
                      image = await pickImage();
                      isThumbnailSelected = true;
                      setState(() {});
                    },
                    child: Text(
                      "Select Thumbnail",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              isThumbnailSelected
                  ? Image.file(
                      image!,
                      cacheHeight: 160,
                      cacheWidth: 400,
                    )
                  : SizedBox(),

              isThumbnailSelected
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            )),
                        child: TextButton(
                          onPressed: () async {
                            // publish video
                            String thumbnail =
                                await putFileInStorage(image, randomNumber, "image");

                            String videoUrl = await putFileInStorage(
                                widget.video, randomNumber, "video");

                            ref.watch(longVideoProvider).uploadVideoToFirestore(
                                  videoPath: videoUrl,
                                  thumbnailPath: thumbnail,
                                  title: titleController.text,
                                  datePublished: DateTime.now(),
                                  videoViews: 0,
                                  videoId: randomNumber,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  likes: [],
                                  type: "video",
                                );
                          },
                          child: Text(
                            "Publish",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
