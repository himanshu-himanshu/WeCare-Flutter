import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:milestone/screens/patient/profile/profile.dart';
import 'package:milestone/size_config.dart';
import 'home_header.dart';
import 'package:http/http.dart' as http;

Future<List<Patient>> fetchPatients() async {
  final response = await http.get(Uri.parse('http://localhost:8001/patients'));
  if (response.statusCode == 200) {
    var k = json.decode(response.body);
    final List result = k['data'];
    print(result);
    return result.map((e) => Patient.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

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
      bloodGroup: json['bloodGroup'],
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "All Patients",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffb74093)),
                  ),
                ),
                Center(
                  child: FutureBuilder<List<Patient>>(
                    future: fetchPatients(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, Profile.routeName);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Gesture Detected!')));
                                  },
                                hoverColor: Colors.amber,
                                  leading: CircleAvatar(
                                      backgroundColor: const Color(0xffb74093),
                                      child: Text(snapshot.data![index].name[0].toUpperCase(), style: const TextStyle(fontSize: 15, color: Colors.white))),
                                  title: Text(snapshot.data![index].name.toString(), style: const TextStyle(fontSize: 15, color: Colors.deepPurple)),
                                trailing:
                                    Text(snapshot.data![index].phone.toString(), style: const TextStyle(fontSize: 12, color: Colors.black45)),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
