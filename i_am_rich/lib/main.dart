import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text('My App'),
        ),
        body: Center(
          child: Image(
            image: NetworkImage('https://jpeg.org/images/jpegxt-home.jpg'),
          ),
        ),
      ),
    ),
  );
}
