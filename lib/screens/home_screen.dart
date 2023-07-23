import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/provider/sign_in_provider.dart';
import 'package:spotify_clone/screens/login_screen.dart';
import 'package:spotify_clone/utils/next_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            sp.userSignOut();
            nextScreen(context, const LoginScreen());
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
