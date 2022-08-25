import 'package:agp_ziauddin_virtual_clinic/doctor_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/other_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

SharedPreferences? prefs;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? checkLogin;
  String? isPatient;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin = prefs!.getBool("islogin") ?? false;
    isPatient = prefs!.getString("type") ?? "Doctor";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AGP ZIAUDDIN VIRTUAL CLINIC",
      theme: ThemeData(primarySwatch: Colors.green),
      home: checkLogin == true
          ? isPatient == "Doctor"
              ? DoctorMainScreen()
              : PatientMainScreen()
          : SplashScreen(),
    );
  }
}
