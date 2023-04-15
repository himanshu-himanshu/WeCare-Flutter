import 'package:flutter/material.dart';
import 'package:milestone/enums.dart';
import 'package:milestone/components/bottom_navbar.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/profile//components/body.dart';

class Profile extends StatelessWidget {
  static String routeName = "/profile";

  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
        ),
      ),
      body: Body(),
    );
  }
}
