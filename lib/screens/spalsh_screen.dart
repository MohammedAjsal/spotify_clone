import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/home_screen.dart';

class SplashScrren extends StatefulWidget {
  const SplashScrren({super.key});
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScrren> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 165,
          child: Image.asset('assets/images/spotify.png'),
        ),
      ),
    );
  }
}
