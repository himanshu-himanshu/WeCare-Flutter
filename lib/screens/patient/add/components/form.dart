import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milestone/constants.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;

class Patient {
  final String name;
  final String phone;
  final String dob;
  final String address;
  final String country;
  final String bloodGroup;

  const Patient(
      {required this.name,
      required this.phone,
      required this.dob,
      required this.address,
      required this.country,
      required this.bloodGroup});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        name: json['name'],
        phone: json['phone'],
        dob: json['dob'],
        address: json['address'],
        country: json['country'],
        bloodGroup: json['bloodGroup']);
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(errorText: '', hintText: '');
  }
}

void addPatient(BuildContext context) async {
  final uri = Uri.parse('http://localhost:8001/patients');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    "name": "test1",
    "phone": "gold",
    "dob": "12/02/1993",
    "address": "16 suburban dr",
    "country": "Canada",
    "bloodGroup": "B+"
  };
  print(body);
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
  print(response);
  int statusCode = response.statusCode;
  String responseBody = response.body;
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  MyCustomFormState({
    Key? key,
    required this.hintText,
    required this.errorText,
    this.onChanged,
    this.validator,
    this.inputFormatters,
  });
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  final _formKey = GlobalKey<FormState>();
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
              validator: (value) {
                if (value == "") {
                  return 'Preencha a senha';
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Preencha a senha';
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter date of birth',
                labelText: 'Dob',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Preencha a senha';
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter address',
                labelText: 'Address',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Preencha a senha';
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter country',
                labelText: 'Country',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Preencha a senha';
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter blood group',
                labelText: 'Blood Group',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Preencha a senha';
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
                width: 320.0,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate()) {
                      addPatient(context);
                    }
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
