import 'package:chapter1/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Chapter1());
}

class Chapter1 extends StatelessWidget {
  const Chapter1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
