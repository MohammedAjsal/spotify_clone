import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_clone/provider/sign_in_provider.dart';
import 'package:spotify_clone/screens/home_screen.dart';
import 'package:spotify_clone/screens/login_screen.dart';
import 'package:spotify_clone/utils/config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final signProvider = context.read<SignInProvider>();
    // signProvider.checkSignInUser();
    super.initState();

    Timer(const Duration(seconds: 3), () {
      signProvider.isSignedIn == false
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const LoginScreen(),
              ),
            )
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const Homescreen(),
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 165,
          child: Image.asset(Config.app_icon),
        ),
      ),
    );
  }
}
