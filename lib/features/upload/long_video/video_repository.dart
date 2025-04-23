import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/long_video/video_model.dart';

final longVideoProvider = Provider<VideoRepository>(
  (ref) => VideoRepository(
    firestore: FirebaseFirestore.instance,
    // auth: FirebaseAuth.instance,
  ),
);

class VideoRepository {
  FirebaseFirestore firestore;
  VideoRepository({
    required this.firestore,
  });

  uploadVideoToFirestore(
      {required String videoPath,
      required String thumbnailPath,
      required String title,
      required DateTime datePublished,
      required int videoViews,
      required String videoId,
      required String userId,
      required List likes,
      required String type}) async {
    VideoModel video = VideoModel(
      videoPath: videoPath,
      thumbnailPath: thumbnailPath,
      title: title,
      datePublished: datePublished,
      videoViews: 0,
      videoId: videoId,
      userId: userId,
      likes: [],
      type: "video",
    );
    print('uploadVideoToFirestore: ${video.toJson()}');

    await firestore.collection("videos").doc(videoId).set(video.toJson());
  }
}
