import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/upload/short_video/model/short_video_model.dart';
import 'package:youtube_clone/features/upload/short_video/pages/short_video_details_page.dart';
import 'package:youtube_clone/features/upload/short_video/widgets/trim_slinder.dart';

class ShortVideoScreen extends StatefulWidget {
  final File shortVideo;

  const ShortVideoScreen({super.key, required this.shortVideo});

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  VideoEditorController? editorController;
  final isExporting = ValueNotifier<bool>(false);
  final exportingProgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    editorController = VideoEditorController.file(
      widget.shortVideo,
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(seconds: 10),
    );
    editorController!
        .initialize(
      aspectRatio: 4 / 3.35,
    )
        .then((_) {
      setState(() {});
    });
  }

  exportVideo() async {
    isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(editorController!);
    final execute = await config.getExecuteConfig();
    final String command = execute.command;

    FFmpegKit.executeAsync(
        command,
        (session) async {
          final ReturnCode? code = await session.getReturnCode();
          if (ReturnCode.isSuccess(code)) {
            // export video
            isExporting.value = false;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShortVideoDetailsPage(
                  video: widget.shortVideo,
                ),
              ),
            );
          } else {
            showErrorSnackBar("Faild, video can not be exported", context);
          }
        },
        null,
        (status) {
          exportingProgress.value =
              config.getFFmpegProgress(status.getTime().toInt());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: editorController!.initialized
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 20,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blueGrey,
                            // backgroundImage: const NetworkImage(
                            //   "https://example.com/profile_picture.jpg",
                            // ),
                          ),
                        ],
                      ),
                    ),
                    CropGridViewer.preview(controller: editorController!),
                    const Spacer(),
                    MyTrimSlider(
                      controller: editorController!,
                      height: 45,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: TextButton(
                            onPressed: () {
                              exportVideo();
                            },
                            child: const Text(
                              "DONE",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
