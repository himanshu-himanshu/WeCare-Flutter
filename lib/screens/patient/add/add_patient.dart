import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milestone/constants.dart';
import 'package:milestone/screens/home/components/body.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/size_config.dart';
import 'package:validatorless/validatorless.dart';

class AddPatient extends StatelessWidget {
  static String routeName = "/add_patient";

  const AddPatient({super.key});
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Patient',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xffb74093)),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(5)),
            child: const MyCustomAddPatientForm()));
  }
}

class MyCustomAddPatientForm extends StatefulWidget {
  const MyCustomAddPatientForm({super.key});

  @override
  MyCustomAddPatientFormState createState() {
    return MyCustomAddPatientFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomAddPatientFormState extends State<MyCustomAddPatientForm> {
  MyCustomAddPatientFormState();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();

  final _formKey = GlobalKey<MyCustomAddPatientFormState>();

  void addPatient(BuildContext context, name, phone, dob, address, country,
      bloodGroup) async {
    final uri = Uri.parse('http://localhost:8001/patients');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "name": name,
      "phone": phone,
      "dob": dob,
      "address": address,
      "country": country,
      "bloodGroup": bloodGroup
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      // String responseBody = response.body;
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter name',
                labelText: 'Name',
              ),
              // ignore: body_might_complete_normally_nullable
              onChanged: (value) {},
              validator: Validatorless.multiple([
                Validatorless.required('Name is required'),
                Validatorless.max(
                    20, 'Name should not exceed more than 20 characters'),
              ]),
              controller: nameCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
                labelText: 'Phone',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple([
                Validatorless.required('Phone is required'),
                Validatorless.max(
                    20, 'Phone No. should not exceed more than 20 characters'),
              ]),
              controller: phoneCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter date of birth',
                labelText: 'Date of Birth',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple([
                Validatorless.required('Date is required'),
                Validatorless.date('2023/30/01 format required'),
              ]),
              controller: dobCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter address',
                labelText: 'Address',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple([
                Validatorless.required('Address is required'),
                Validatorless.max(
                    200, 'Address. should not exceed more than 200 characters'),
              ]),
              controller: addressCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter country',
                labelText: 'Country',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple([
                Validatorless.required('Country is required'),
                Validatorless.max(
                    20, 'Country should not exceed more than 20 characters'),
              ]),
              controller: countryCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter blood group',
                labelText: 'Blood Group',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('Blood Group is required')]),
              controller: bloodGroupCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
                width: 320.0,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // print(
                    //     "${nameCtrl.text}, ${phoneCtrl.text}, ${dobCtrl.text}, ${addressCtrl.text}, ${countryCtrl.text}, ${bloodGroupCtrl.text}");
                    var msg = "";
                    if (nameCtrl.text.isEmpty) {
                      msg = "Name is required\n ";
                    }
                    if (phoneCtrl.text.isEmpty) {
                      msg += "Phone is required\n ";
                    }
                    if (dobCtrl.text.isEmpty) {
                      msg += "DOB is required\n ";
                    }
                    if (addressCtrl.text.isEmpty) {
                      msg += "Address is required\n ";
                    }
                    if (countryCtrl.text.isEmpty) {
                      msg += "Country is required\n ";
                    }
                    if (bloodGroupCtrl.text.isEmpty) {
                      msg += "Blood Group is required\n ";
                    }
                    // print(msg);
                    if (!msg.isEmpty) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text("$msg"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                    addPatient(
                        context,
                        nameCtrl.text,
                        phoneCtrl.text,
                        dobCtrl.text,
                        addressCtrl.text,
                        countryCtrl.text,
                        bloodGroupCtrl.text);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 10,
                      backgroundColor: kPrimaryColor,
                      textStyle: const TextStyle(fontSize: 20)),
                  child: const Text("Register"),
                )),
          ],
        ),
      ),
    );
  }
}
