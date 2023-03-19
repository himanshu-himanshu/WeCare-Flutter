import 'package:flutter/material.dart';
import 'package:milestone/enums.dart';
import 'package:milestone/components/bottom_navbar.dart';
import 'package:milestone/screens/patient/tests/components/body.dart';

class Tests extends StatelessWidget {
  static String routeName = "/tests";

  const Tests({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
