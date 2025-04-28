import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/features/upload/comments/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;

  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.5, right: 8, left: 8),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                backgroundImage:
                    CachedNetworkImageProvider(comment.profielePicture),
              ),
              const SizedBox(width: 7),
              Text(
                comment.displayName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                " 2 days ago",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black26,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                size: 15,
                color: Colors.grey,
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.7),
            child: Text(
              comment.commentText,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
