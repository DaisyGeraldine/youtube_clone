import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/long_video/parts/video.dart';
import 'package:youtube_clone/features/upload/long_video/video_model.dart';

class Post extends ConsumerWidget {
  final VideoModel video;

  const Post({super.key, required this.video});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel =
        ref.watch(anyUserDataProvider(video.userId));
    final user = userModel.whenData((user) => user);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Video(),
          ),
        );
      },
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: video.thumbnailPath),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 5),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(user.value!.profilePicture),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  video.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.12),
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    user.value?.displayName ?? "Loading...",
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(video.videoViews == 0
                      ? "No View"
                      : "${video.videoViews.toString()} views"),
                ),
                Text("1 day ago"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
