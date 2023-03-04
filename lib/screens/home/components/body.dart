import 'dart:convert';

import 'package:flutter/material.dart';
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
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "All Patients",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
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
                            return ListTile(
                              title:
                                  Text(snapshot.data![index].name.toString()),
                              trailing:
                                  Text(snapshot.data![index].phone.toString()),
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
            // DiscountBanner(),
            // Categories(),
            // SpecialOffers(),
            // SizedBox(height: getProportionateScreenWidth(30)),
            // PopularProducts(),
            // SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
