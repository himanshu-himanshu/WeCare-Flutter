import 'package:flutter/material.dart';
import 'package:milestone/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              const Text("Himanshu",
                  style: TextStyle(
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
                      const SizedBox(width: 40),
                      Expanded(
                        child: SizedBox(
                          width: 130,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {},
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
                            onPressed: () {},
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
            const SizedBox(height: 10),

            /// ********** DETAILS ABOUT PATIENT ********** ///




          ],
        ),
      ),
    );
  }
}
