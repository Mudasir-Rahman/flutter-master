import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('images/mudaser.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            'Mudaser',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Flutter Developer',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 50,
              endIndent: 50,
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
              leading: Icon(Icons.phone, color: Colors.teal),
              title: Text('+1234567890'),
            ),
          ),
          SizedBox(height: 10),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
              leading: Icon(Icons.email, color: Colors.teal),
              title: Text('mudaser@example.com'),
            ),
          ),
        ],
      ),
    );
  }
}
