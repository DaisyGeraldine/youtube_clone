import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/content/long_video/parts/post.dart';
import 'package:youtube_clone/features/upload/long_video/video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("videos").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const ErrorPage();
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        final videoMaps = snapshot.data!.docs;
        final videos = videoMaps.map(
          (video) {
            return VideoModel.fromJson(video.data());
          },
        ).toList();
        print('videos: ${videos.length}');
        return ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Post(
              video: videos[index],
            );
          },
        );
      },
    ));
  }
}
