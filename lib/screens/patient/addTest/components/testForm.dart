import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/tests/tests.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:validatorless/validatorless.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

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
  final bpLowCtrl = TextEditingController();
  final bpHighCtrl = TextEditingController();
  final respiratoryRateCtrl = TextEditingController();
  final bloodOxygenCtrl = TextEditingController();
  final heartBeatCtrl = TextEditingController();
  final riskCtrl = TextEditingController();

  final _formKey = GlobalKey<MyCustomFormState>();

  void addTest(BuildContext context, bpLow, bpHigh, respiratoryRate,
      bloodOxygen, heartBeat, risk) async {
    const id = "642a3a223979691cc9f15b07";
    final uri = Uri.parse('http://localhost:8001/patients/$id/tests');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "bloodPressureHigh": bpLow,
      "bloodPressureLow": bpHigh,
      "respiratoryRate": respiratoryRate,
      "bloodOxygen": bloodOxygen,
      "heartBeat": heartBeat,
      "risk": risk
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    // http.Response response = await http.post(
    await http.post(uri, headers: headers, body: jsonBody, encoding: encoding);
    // int statusCode = response.statusCode;
    // String responseBody = response.body;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tests()),
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
              validator: Validatorless.multiple(
                  [Validatorless.required('Low Bp Is required')]),
              controller: bpLowCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Diastolic (mmHg)',
                labelText: 'Blood Pressure',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('High Bp is required')]),
              controller: bpHighCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Respiratory Rate (X/min)',
                labelText: 'Respiratory Rate',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('Respiratory Rate is required')]),
              controller: respiratoryRateCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Blood Oxygen Level (X%)',
                labelText: 'Blood Oxygen',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('Blood Oxygen Level is required')]),
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
              validator: Validatorless.multiple(
                  [Validatorless.required('Heart Beat is required')]),
              controller: heartBeatCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Risk Level',
                labelText: 'Risk',
              ),
              onChanged: (value) {},
              validator: Validatorless.multiple(
                  [Validatorless.required('Risk Level is required')]),
              controller: riskCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
                width: 340.0,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    print(
                        "${bpLowCtrl.text}, ${bpHighCtrl.text}, ${respiratoryRateCtrl.text}, ${bloodOxygenCtrl.text}, ${heartBeatCtrl.text}, ${riskCtrl.text}");
                    var msg = "";
                    if (bpLowCtrl.text.isEmpty) {
                      msg = "Low Bp is required\n ";
                    }
                    if (bpHighCtrl.text.isEmpty) {
                      msg += "High Bp is required\n ";
                    }
                    if (respiratoryRateCtrl.text.isEmpty) {
                      msg += "Respiratory Rate is required\n";
                    }
                    if (bloodOxygenCtrl.text.isEmpty) {
                      msg += "Blood Oxygen is required\n";
                    }
                    if (heartBeatCtrl.text.isEmpty) {
                      msg += "Heart Beat is required\n";
                    }
                    if (riskCtrl.text.isEmpty) {
                      msg += "Risk Level is required\n";
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
                    addTest(
                        context,
                        bpLowCtrl.text,
                        bpHighCtrl.text,
                        respiratoryRateCtrl.text,
                        bloodOxygenCtrl.text,
                        heartBeatCtrl.text,
                        riskCtrl.text);
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
