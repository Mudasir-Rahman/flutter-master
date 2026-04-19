// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blueGrey[900],
//           title: Text('My App'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Image.network('https://jpeg.org/images/jpegxt-home.jpg'),
//               // Image(
//               //   image: NetworkImage('https://jpeg.org/images/jpegxt-home.jpg'),
//               // ),
//               SizedBox(height: 5),
//               Image(image: AssetImage('images/diamond.jpg')),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Text('My App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://picsum.photos/200',
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Failed to load image');
                },
              ),
              const SizedBox(height: 10),
              Image.asset('images/diamond.jpg'),
            ],
          ),
        ),
      ),
    ),
  );
}
