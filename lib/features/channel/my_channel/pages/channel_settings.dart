import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/channel/my_channel/repository/edit_field.dart';
import 'package:youtube_clone/features/channel/my_channel/widgets/edit_setting_dialog.dart';
import 'package:youtube_clone/features/channel/my_channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwiched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) => Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: 170,
                            width: double.infinity,
                            child: Image.asset(
                              "assets/images/flutter background.png",
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                          left: 180,
                          top: 60,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(currentUser.profilePicture),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 10,
                          child: Image.asset(
                            "assets/icons/camera.png",
                            height: 38,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    //second part
                    SettingsItem(
                      identifier: "Name",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SettingsDialog(
                            identifier: "Your New Display Name",
                            onSave: (channelName) {
                              ref
                                  .watch(editSettingsProvider)
                                  .editDisplayName(channelName);
                            },
                          ),
                        );
                      },
                      value: currentUser.displayName,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Handle",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SettingsDialog(
                            identifier: "Your New username",
                            onSave: (channelName) {
                              ref
                                  .watch(editSettingsProvider)
                                  .editUserName(channelName);
                            },
                          ),
                        );
                      },
                      value: currentUser.username,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Description",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SettingsDialog(
                            identifier: "Your Description",
                            onSave: (channelName) {
                              ref
                                  .watch(editSettingsProvider)
                                  .editDescription(channelName);
                            },
                          ),
                        );
                      },
                      value: currentUser.description,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Keep all my subcrivers private"),
                          Switch(
                              value: isSwiched,
                              onChanged: (value) {
                                isSwiched = value;
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Text(
                        "Changes made on your names and profile pictures are visible only to youtube and not other Google Services",
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorPage(),
          loading: () => Loader(),
        );
  }
}
