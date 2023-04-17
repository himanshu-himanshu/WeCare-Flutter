import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:milestone/screens/home/components/icon_button.dart';
import 'package:milestone/screens/patient/addTest/addTest.dart';
// import 'package:milestone/screens/patient/profile/profile.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;

Future<List<Test>> fetchTests() async {
  const id = "643cb52b0f61066aec545d9a";
  final response = await http
      .get(Uri.parse('http://localhost:8001/patients/' + id + '/tests'));
  if (response.statusCode == 200) {
    var k = json.decode(response.body);
    // print('response');
    // print(k['tests']);
    final List result = k['tests'];
    // if (result.isNotEmpty) {
    print(result.map((e) => Test.fromJson(e)).toList());
    return result.map((e) => Test.fromJson(e)).toList();
    // }
    // return [];
  } else {
    throw Exception('Failed to load data');
  }
}

class ProfileScreenArguments {
  final String id;
  ProfileScreenArguments(this.id);
}

class Test {
  final String id;
  final String risk;
  final String bloodPressureLow;
  final String bloodPressureHigh;
  final String respiratoryRate;
  final String heartBeat;
  final String bloodOxygen;

  const Test(
      {required this.id,
      required this.risk,
      required this.bloodPressureLow,
      required this.bloodPressureHigh,
      required this.respiratoryRate,
      required this.heartBeat,
      required this.bloodOxygen});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'],
      risk: json['risk'],
      bloodPressureLow: json['bloodPressureLow'],
      bloodPressureHigh: json['bloodPressureHigh'],
      respiratoryRate: json['respiratoryRate'],
      heartBeat: json['heartBeat'],
      bloodOxygen: json['bloodOxygen'],
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as ProfileScreenArguments;
    // print('args');
    // print(args);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SearchField(),
                  /** Icon for showing number of critical patient's*/
                  IconBtnWithCounter(
                    svgSrc: "assets/icons/Plus Icon.svg",
                    numOfitem: 0,
                    press: () =>
                        Navigator.pushNamed(context, AddTest.routeName),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    future: fetchTests(),
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
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Record'),
                                      content: Text(
                                          "Risk: ${snapshot.data![index].risk} \nBp: ${snapshot.data![index].bloodPressureLow} ${snapshot.data![index].bloodPressureHigh}\nRespiratory Rate:${snapshot.data![index].respiratoryRate}\nBlood Oxygen: ${snapshot.data![index].bloodOxygen}\nHeartBeat: ${snapshot.data![index].heartBeat}"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  // Navigator.pushNamed(context, Profile.routeName);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //         content: Text('Go To Test')));
                                },
                                hoverColor: Colors.amber,
                                leading: CircleAvatar(
                                    backgroundColor: const Color(0xffb74093),
                                    child: Text(
                                        snapshot.data![index].risk[0]
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
                                    snapshot.data![index].risk.toString(),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black45)),
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
