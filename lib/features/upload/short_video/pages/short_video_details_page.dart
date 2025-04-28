import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class ShortVideoDetailsPage extends StatefulWidget {
  final File video;
  const ShortVideoDetailsPage({super.key,
  required this.video,});

  @override
  State<ShortVideoDetailsPage> createState() => _ShortVideoDetailsPAgeState();
}

class _ShortVideoDetailsPAgeState extends State<ShortVideoDetailsPage> {
  final captionController = TextEditingController();
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Video Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: captionController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Write a caption",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: FlatButton(
                    text: "PUBLISH", onPressed: () {}, colour: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
