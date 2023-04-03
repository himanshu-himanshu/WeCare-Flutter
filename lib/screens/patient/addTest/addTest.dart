import 'package:flutter/material.dart';
import 'package:milestone/screens/patient/addTest/components/body.dart';
import 'package:milestone/screens/patient/tests/tests.dart';

class AddTest extends StatelessWidget {
  static String routeName = "/add_test";

  const AddTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Tests()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Add Test Record",
          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
        ),
      ),
      body: Body(),
    );
  }
}
