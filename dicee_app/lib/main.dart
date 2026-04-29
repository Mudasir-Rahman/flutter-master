import 'package:dicee_app/diacee_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red.shade400,
        appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          title: Center(
            child: Text(
              'Dicee App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: DicePage(),
      ),
    ),
  );
}
