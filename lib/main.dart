import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/spalsh_screen.dart';

final color = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(151, 151, 151, 151),
    brightness: Brightness.dark,
    background: Colors.white);

final theme = ThemeData().copyWith(
  useMaterial3: false,
  colorScheme: color,
);
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScrren(),
    ),
  );
}
