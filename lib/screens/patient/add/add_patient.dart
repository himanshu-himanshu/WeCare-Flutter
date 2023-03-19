import 'package:flutter/material.dart';
import 'package:milestone/enums.dart';
import 'package:milestone/components/bottom_navbar.dart';
import 'package:milestone/screens/patient/add/components/body.dart';

class AddPatient extends StatelessWidget {
  static String routeName = "/add_patient";

  const AddPatient({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Add Patient"),
      // ),
      body: Body(),
    );
  }
}
