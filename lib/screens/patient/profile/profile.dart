import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milestone/screens/home/components/body.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/edit/edit_patient.dart';
import 'package:milestone/screens/patient/tests/tests.dart';
import 'package:milestone/size_config.dart';

class Profile extends StatelessWidget {
  static String routeName = "/profile";

  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    void deletePatient(BuildContext context, id) async {
      final uri = Uri.parse('http://localhost:8001/patients/${id}');
      final headers = {'Content-Type': 'application/json'};
      final encoding = Encoding.getByName('utf-8');

      http.Response response = await http.delete(
        uri,
        headers: headers,
        encoding: encoding,
      );
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        // String responseBody = response.body;
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                        'https://xsgames.co/randomusers/assets/images/favicon.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(args.name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                Text(args.phone,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.blueGrey)),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 40),
                        Expanded(
                          child: SizedBox(
                            width: 130,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, EditPatient.routeName,
                                    arguments: ScreenArguments(
                                        args.id,
                                        args.name,
                                        args.phone,
                                        args.dob,
                                        args.address,
                                        args.country,
                                        args.bloodGroup));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("Edit Patient",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: SizedBox(
                            width: 130,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Tests.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("View Records",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ],
                )
              ]),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 50),

              /// ********** DETAILS ABOUT PATIENT ********** ///

              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 5,
                          child: Text("Blood Group: ${args.bloodGroup}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 40),
                        Expanded(
                            flex: 5,
                            child: Text('Country: ${args.country}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 5,
                          child: Text("Dob: ${args.dob}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      borderOnForeground: true,
                      color: Colors.red.shade50,
                      elevation: 2,
                      child: InkWell(
                        splashColor: Colors.red.withAlpha(90),
                        onTap: () {
                          deletePatient(context, args.id);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Patient Delete')));
                        },
                        child: const SizedBox(
                          width: 300,
                          height: 50,
                          child: Center(
                              child: Text('Delete Patient',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
