import 'package:flutter/material.dart';
import 'package:milestone/size_config.dart';

import '../../addTest/components/testForm.dart';

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
              children: const [
                SizedBox(height: 20),
                Text("Fill details below to add a test for patientName."),
                SizedBox(height: 30),
                MyCustomTestForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
