import 'package:flutter/material.dart';

void nextScreen(context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => page));
}

void nextScreenReplace(context, page) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => page));
}
