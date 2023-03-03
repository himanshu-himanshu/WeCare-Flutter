import 'package:flutter/material.dart';
import 'package:milestone/screens/patient/add/components/add_patient_header.dart';
import 'package:milestone/screens/patient/add/components/form.dart';
import 'package:milestone/size_config.dart';
import 'form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
               AddPatientHeader(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                MyCustomForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}