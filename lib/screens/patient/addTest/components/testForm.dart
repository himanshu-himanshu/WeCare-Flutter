import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milestone/constants.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:validatorless/validatorless.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm();

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  MyCustomFormState();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();

  final _formKey = GlobalKey<MyCustomFormState>();

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
    // int statusCode = response.statusCode;
    // String responseBody = response.body;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Systolic (mmHg)',
                labelText: 'Blood Pressure',
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Diastolic (mmHg)',
                labelText: 'Blood Pressure',
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Respiratory Rate (X/min)',
                labelText: 'Respiratory Rate',
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Blood Oxygen Level (X%)',
                labelText: 'Blood Oxygen',
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Heartbeat Rate (X/min)',
                labelText: 'Heartbeat',
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
                hintText: 'Risk Level',
                labelText: 'Risk',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('Blood Group is required')]),
              controller: bloodGroupCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
                width: 340.0,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    print(
                        "${nameCtrl.text}, ${phoneCtrl.text}, ${dobCtrl.text}, ${addressCtrl.text}, ${countryCtrl.text}, ${bloodGroupCtrl.text}");
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
                    print(msg);
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
                      backgroundColor: Colors.deepPurple.shade300,
                      textStyle: const TextStyle(fontSize: 20)),
                  child: const Text("Add Test"),
                )),
          ],
        ),
      ),
    );
  }
}
