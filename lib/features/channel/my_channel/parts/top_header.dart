import 'package:flutter/material.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(user.profilePicture),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Text(
            user.displayName,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.blueGrey,
              ),
              // text: "You have not created any channel yet. ",
              children: [
                TextSpan(
                  text: "${user.username} ",
                ),
                TextSpan(
                  text: "${user.subscriptions} subscriptions",
                ),
                TextSpan(text: "${user.videos} videos"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
