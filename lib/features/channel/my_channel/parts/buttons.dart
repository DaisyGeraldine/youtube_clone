import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/widgets/image_button.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 41,
              decoration: BoxDecoration(
                  color: softBlueGreyBackGround,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: TextButton(
                onPressed: () {},
                child: Text("Manage Videos",
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
            ),
          ),
          Expanded(
            child: ImageButton(
              image: "pen.png",
              onPressed: () {},
              haveColor: true,
            ),
          ),
          Expanded(
            child: ImageButton(
              image: "time-watched.png",
              onPressed: () {},
              haveColor: true,
            ),
          ),
        ],
      ),
    );
  }
}
