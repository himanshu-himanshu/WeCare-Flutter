import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/profile/profile.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;
import '../../../patient/tests//components/tests_header.dart';

Future<List<Test>> fetchTestRecords() async {
  const patientId = "642a3a223979691cc9f15b07";
  final response = await http
      .get(Uri.parse('http://localhost:8001/patients/${patientId}/tests'));
  if (response.statusCode == 200) {
    var k = json.decode(response.body);
    print('response ll l l l k : ${k}');
    final List result = k['tests'];
    print(result);
    return result.map((e) => Test.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class Test {
  final String bloodPressureLow;
  final String bloodPressureHigh;
  final String respiratoryRate;
  final String bloodOxygen;
  final String heartBeat;
  final String risk;

  const Test(
      {required this.bloodPressureLow,
      required this.bloodPressureHigh,
      required this.respiratoryRate,
      required this.bloodOxygen,
      required this.heartBeat,
      required this.risk});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
        bloodPressureLow: json['bloodPressureLow'],
        bloodPressureHigh: json['bloodPressureHigh'],
        respiratoryRate: json['respiratoryRate'],
        bloodOxygen: json['bloodOxygen'],
        heartBeat: json['heartBeat'],
        risk: json['risk']);
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
            SizedBox(height: getProportionateScreenWidth(10)),
            const TestsHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                    child: const Text(
                      "Go To Patients' Screen",
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Test Records",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffb74093)),
                  ),
                ),
                Center(
                  child: FutureBuilder<List<Test>>(
                    future: fetchTestRecords(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: ListTile(
                                onTap: () {
                                  // Navigator.pushNamed(context, Profile.routeName);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Go To Test')));
                                },
                                hoverColor: Colors.amber,
                                leading: CircleAvatar(
                                    backgroundColor: const Color(0xffb74093),
                                    child: Text(
                                        snapshot.data![index]
                                                .bloodPressureLow[0]
                                                .toUpperCase() +
                                            snapshot.data![index]
                                                .bloodPressureHigh[0]
                                                .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white))),
                                title: Text(
                                    snapshot.data![index].risk.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.deepPurple)),
                                trailing: Text(
                                    snapshot.data![index].respiratoryRate
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black45)),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        // return Text('${snapshot.error}');
                        return const Text('No Test Records Found!');
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
