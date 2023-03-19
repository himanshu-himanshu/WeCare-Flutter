import 'package:flutter/material.dart';
import 'package:milestone/enums.dart';
import 'package:milestone/components/bottom_navbar.dart';
import 'package:milestone/screens/patient/profile//components/body.dart';

class Profile extends StatelessWidget {
  static String routeName = "/profile";

  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back),),
        title: Text("Profile", style: TextStyle(color: Colors.deepPurple, fontSize: 20),),
      ),
      body: Body(),
    );
  }
}
