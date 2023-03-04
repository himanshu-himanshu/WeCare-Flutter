import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Patient> fetchPatient() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/Patients/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Patient.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Patient');
  }
}

class Patient {
  final String name;
  final String phone;
  final String dob;
  final String address;
  final String country;
  final String bloodGroup;
  final int id;

  const Patient(
      {required this.name,
      required this.phone,
      required this.dob,
      required this.address,
      required this.country,
      required this.bloodGroup,
      required this.id});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      phone: json['phone'],
      dob: json['dob'],
      address: json['address'],
      country: json['country'],
      bloodGroup: json['bloodGroup'],
      id: json['id'],
    );
  }
}

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  late Future<Patient> futurePatient;

  @override
  void initState() {
    super.initState();
    futurePatient = fetchPatient();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Patient>(
            future: futurePatient,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Text("snapshot.data!.title");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
