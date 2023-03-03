import 'package:flutter/material.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/add/add_patient.dart';
import 'package:milestone/size_config.dart';
import 'icon_button.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          /** Icon for showing number of critical patient's*/
          IconBtnWithCounter(
            svgSrc: "assets/icons/Plus Icon.svg",
            numOfitem: 0,
            press: () =>
                Navigator.pushNamed(context, AddPatient.routeName),
          ),
        ],
      ),
    );
  }
}
