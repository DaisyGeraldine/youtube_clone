import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';

class ShortVideoRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ShortVideoRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> addShortVideoToFirebase({
    required String caption,
    required String userId,
    required String video,
    required DateTime datePublished,
  }) async {
    ShortVideoModel shortVideo = ShortVideoModel(
      caption: caption,
      userId: userId,
      shortVideo: video,
      datePublished: datePublished,
    );

    await firestore.collection("shorts").add(shortVideo.toJson());
  }
}
