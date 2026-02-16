import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Catalog App")),
        backgroundColor: Colors.blue,
      ),
      body: Material(
        child: Container(child: Center(child: Text("Wellcome to Flutter"))),
      ),
    );
  }
}
