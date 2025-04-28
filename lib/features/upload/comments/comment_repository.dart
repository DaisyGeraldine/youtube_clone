import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/features/upload/comments/comment_model.dart';

final commentProvider = Provider(
  (ref) => CommentRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class CommentRepository {
  final FirebaseFirestore firestore;

  CommentRepository({
    required this.firestore,
  });

  Future<void> uploadCommentFirestore({
    required String commentText,
    required String videoId,
    required String displayName,
    required String profilePicture,
  }) async {
    String commentId = const Uuid().v4();
    CommentModel comment = CommentModel(
      commentText: commentText,
      videoId: videoId,
      commentId: commentId,
      displayName: displayName,
      profielePicture: profilePicture,
    );
    await firestore.collection("comments").doc(commentId).set(comment.toJson());
  }
}
