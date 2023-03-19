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
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();
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
                  return 'Enter Name';
                }
                return null;
              },
              controller: nameCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Enter phone number';
                }
                return null;
              },
              controller: phoneCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter date of birth',
                labelText: 'Dob',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Enter date of birth';
                }
                return null;
              },
              controller: dobCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter address',
                labelText: 'Address',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Enter address';
                }
                return null;
              },
              controller: addressCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter country',
                labelText: 'Country',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Enter country';
                }
                return null;
              },
              controller: countryCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter blood group',
                labelText: 'Blood Group',
              ),
              validator: (value) {
                if (value == "") {
                  return 'Enter blood group';
                }
                return null;
              },
              controller: bloodGroupCtrl,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SizedBox(
                width: 320.0,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
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
