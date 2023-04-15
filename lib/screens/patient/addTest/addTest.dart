import 'package:flutter/material.dart';
import 'package:milestone/enums.dart';
import 'package:milestone/components/bottom_navbar.dart';
import 'package:milestone/screens/patient/addTest/components/body.dart';

class AddTest extends StatelessWidget {
  static String routeName = "/add_test";

  const AddTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Add Record",
          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
        ),
      ),
      body: Body(),
    );
  }
}
