import 'package:flutter/widgets.dart';
import 'screens/splash/splash_screen.dart';
import 'package:milestone/screens/home/home_screen.dart';
import 'package:milestone/screens/patient/add/add_patient.dart';
import 'package:milestone/screens/patient/profile/profile.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AddPatient.routeName: (context) => AddPatient(),
  Profile.routeName: (context) => Profile(),
};
