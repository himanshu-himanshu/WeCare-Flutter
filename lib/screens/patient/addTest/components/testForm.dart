import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:milestone/constants.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/tests/tests.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:validatorless/validatorless.dart';

class MyCustomTestForm extends StatefulWidget {
  const MyCustomTestForm({super.key});

  @override
  MyCustomTestFormState createState() {
    return MyCustomTestFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomTestFormState extends State<MyCustomTestForm> {
  MyCustomTestFormState();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final sysBpCtrl = TextEditingController();
  final diaBpCtrl = TextEditingController();
  final respiratoryCtrl = TextEditingController();
  final bloodOxygenCtrl = TextEditingController();
  final heartbeatCtrl = TextEditingController();
  final riskCtrl = TextEditingController();

  final _formKey = GlobalKey<MyCustomTestFormState>();

  void addTestRecord(BuildContext context, name, phone, dob, address, country,
      bloodGroup) async {
    const patientId = "6417cfd176b2a01e6ebe18b7";
    final uri = Uri.parse('http://localhost:8001/patients/${patientId}/tests');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "bloodPressureLow": sysBpCtrl.text,
      "bloodPressureHigh": diaBpCtrl.text,
      "respiratoryRate": respiratoryCtrl.text,
      "bloodOxygen": bloodOxygenCtrl.text,
      "heartBeat": heartbeatCtrl.text,
      "risk": riskCtrl.text
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Tests()),
      );
    }
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
                Validatorless.required('Low BP value is required'),
                Validatorless.max(3, 'Should not be more than 3 characters'),
              ]),
              controller: sysBpCtrl,
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
                Validatorless.required('High Bp value is required'),
                Validatorless.max(3, 'Should not be more than 100'),
              ]),
              controller: diaBpCtrl,
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
                Validatorless.required('Respiratory Rate is required'),
              ]),
              controller: respiratoryCtrl,
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
                Validatorless.required('Blood oxygen level is required'),
              ]),
              controller: bloodOxygenCtrl,
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
                Validatorless.required('Heartbeat value is required'),
              ]),
              controller: heartbeatCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Risk Level',
                labelText: 'Risk',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('Risk level is required')]),
              controller: riskCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
                width: 340.0,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    print(
                        "${sysBpCtrl.text}, ${diaBpCtrl.text}, ${respiratoryCtrl.text}, ${bloodOxygenCtrl.text}, ${heartbeatCtrl.text}, ${riskCtrl.text}");
                    var msg = "";
                    if (sysBpCtrl.text.isEmpty) {
                      msg = "Low BP value is required\n ";
                    }
                    if (diaBpCtrl.text.isEmpty) {
                      msg += "High Bp value is required\n ";
                    }
                    if (respiratoryCtrl.text.isEmpty) {
                      msg += "Respiratory Rate is required\n ";
                    }
                    if (bloodOxygenCtrl.text.isEmpty) {
                      msg += "Blood oxygen level is required\n ";
                    }
                    if (heartbeatCtrl.text.isEmpty) {
                      msg += "Heartbeat value is required\n ";
                    }
                    if (riskCtrl.text.isEmpty) {
                      msg += "Risk level is required\n ";
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
                    } else {
                      addTestRecord(
                          context,
                          sysBpCtrl.text,
                          diaBpCtrl.text,
                          respiratoryCtrl.text,
                          bloodOxygenCtrl.text,
                          heartbeatCtrl.text,
                          riskCtrl.text);
                    }
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
