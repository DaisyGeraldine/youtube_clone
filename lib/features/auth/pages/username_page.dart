import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';

final formKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String email;
  final String profilePic;
  const UsernamePage({
    required this.displayName,
    required this.email,
    required this.profilePic
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool isValidate = true;

  void validateUsername() async {
    final usersMap = await FirebaseFirestore.instance.collection('users').get();
    final users = usersMap.docs.map((e) => e).toList();

    String? targetUsername;

    for (var user in users) {
      if (_usernameController.text == user.data()['username']) {
        targetUsername = user.data()['username'];
        isValidate = false;
        setState(() {});
      }
      if (_usernameController.text != targetUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 26),
          child: Text('Enter the username',
              style: TextStyle(
                  // fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Form(
            child: TextFormField(
              onChanged: (value) {
                validateUsername();
              },
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                return isValidate ? null : "username already taken";
              },
              key: formKey,
              controller: _usernameController,
              decoration: InputDecoration(
                suffix: isValidate
                    ? Icon(
                        Icons.verified_user_rounded,
                      )
                    : Icon(
                        Icons.cancel,
                      ),
                suffixIconColor: isValidate ? Colors.green : Colors.red,
                hintText: 'Insert Username',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 8, right: 8),
          child: FlatButton(
            text: 'CONTINUE',
            onPressed: () async {
              // add users data
              isValidate
                  ? await ref
                      .read(userDataServiceProvider)
                      .addUserDataToFirestore(
                          displayName: widget.displayName,
                          username: _usernameController.text,
                          email: widget.email,
                          photoURL: widget.profilePic,
                          description: "")
                  : null;
            },
            colour: isValidate ? Colors.green : Colors.green.shade200,
          ),
        ),
      ])),
    );
  }
}
