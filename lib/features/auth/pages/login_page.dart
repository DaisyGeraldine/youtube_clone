import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/auth_service.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 25),
                child: Image.asset(
                  'assets/images/youtube-signin.png',
                  height: 150,
                ),
              ),
              Text(
                'Welcome to Youtube Clone',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () async {
                   await ref.read(authServiceProvider).signInWithGoogle();
                  },
                  child: Image.asset(
                    'assets/images/signinwithgoogle.png',
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
