import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/comment/comment_tile.dart';
import 'package:youtube_clone/features/upload/comments/comment_model.dart';
import 'package:youtube_clone/features/upload/comments/comment_repository.dart';
import 'package:youtube_clone/features/upload/long_video/video_model.dart';

class CommentSheet extends ConsumerStatefulWidget {
  final VideoModel video;

  const CommentSheet({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).whenData(
      (user) {
        return user;
      },
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Comments",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
              Text("${0}"),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
          ),
          child: Text(
            "Remenber to keep comments respectful and to follow our comunity and guideline",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black26,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("comments")
                .where("videoId", isEqualTo: widget.video.videoId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              final commentMaps = snapshot.data!.docs;
              final List<CommentModel> comments = commentMaps.map(
                (comment) {
                  return CommentModel.fromJson(comment.data());
                },
              ).toList();

              print('comments: ${comments.length}');

              return ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentTile(
                    comment: comments[index],
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 8, left: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "Add a public comment...",
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.black26,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await ref.watch(commentProvider).uploadCommentFirestore(
                      commentText: commentController.text,
                      videoId: widget.video.videoId,
                      displayName: user.value!.displayName,
                      profilePicture: user.value!.profilePicture);
                },
                icon: const Icon(
                  Icons.send,
                  size: 35,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
