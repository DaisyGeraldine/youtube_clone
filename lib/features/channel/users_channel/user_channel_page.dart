import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class UserChannelPage extends StatefulWidget {
  const UserChannelPage({super.key});

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  bool haveVideos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/flutter background.png"),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          AssetImage("assets/images/flutter background.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Name ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "email ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: "0 subscriptions",
                                ),
                                TextSpan(text: "0 videos"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                child: FlatButton(
                    text: "SUBSCRIBE", onPressed: () {}, colour: Colors.black),
              ),
              haveVideos
                  ? SizedBox()
                  : Center(
                      child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.2),
                      child: Text(
                        "No Video",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
