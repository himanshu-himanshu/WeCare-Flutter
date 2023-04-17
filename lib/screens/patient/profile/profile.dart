import 'package:flutter/material.dart';
import 'package:milestone/screens/home/components/body.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'dart:convert';
import 'package:milestone/screens/patient/tests/tests.dart';
import 'package:milestone/size_config.dart';
import 'package:http/http.dart' as http;

class Profile extends StatelessWidget {
  static String routeName = "/profile";
  void deletePatient(BuildContext context, id) async {
    id = "643cb4880f61066aec545d22";
    final uri = Uri.parse('http://localhost:8001/patients/$id');
    final headers = {'Content-Type': 'application/json'};
    // Map<String, dynamic> body = {
    //   "bloodPressureHigh": bpLow,
    //   "bloodPressureLow": bpHigh,
    //   "respiratoryRate": respiratoryRate,
    //   "bloodOxygen": bloodOxygen,
    //   "heartBeat": heartBeat,
    //   "risk": risk
    // };
    // String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    // http.Response response = await http.post(
    // http.Response response =
    await http.delete(uri, headers: headers, encoding: encoding);
    // int statusCode = response.statusCode;
    // String responseBody = response.body;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    print('args');
    print(args.id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
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
                const Text("+1-622-112-2323",
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      children: [
                        // const SizedBox(width: 40),
                        // Expanded(
                        //   child: SizedBox(
                        //     width: 130,
                        //     height: 55,
                        //     child: ElevatedButton(
                        //       onPressed: () {},
                        //       style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.blue,
                        //           side: BorderSide.none,
                        //           shape: const StadiumBorder()),
                        //       child: const Text("Edit Patient",
                        //           style: TextStyle(color: Colors.white)),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: SizedBox(
                            width: 130,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Tests.routeName,
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
                      children: const [
                        SizedBox(width: 40),
                        Expanded(
                          flex: 5,
                          child: Text("Age: 27",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 5,
                          child: Text("Blood Group: A+",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(width: 40),
                        Expanded(
                          flex: 5,
                          child: Text("Gender: Male",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 5,
                          child: Text("Country: Canada",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        // SizedBox(width: 40),
                        // Expanded(
                        //   flex: 5,
                        //   child: Text("Risk: Moderate",
                        //       style: TextStyle(
                        //           fontSize: 16, fontWeight: FontWeight.w600)),
                        // ),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 5,
                          child: Text("Total Tests: 0",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(width: 40),
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
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Patient Delete'))
                          // );
                          // const id = "643cb4880f61066aec545d22";
                          deletePatient(context, args.id);
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
