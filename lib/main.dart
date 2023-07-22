import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/provider/sign_in_provider.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        ),
      ],
      child: const MaterialApp(
        // theme: theme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
