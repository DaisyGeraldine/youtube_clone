import 'package:flutter/material.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Text('Enter the username',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              suffix: Icon(
                Icons.verified_user_rounded,
              ),
              suffixIconColor: Colors.green,
              hintText: 'Username',
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
      ])),
    );
  }
}
