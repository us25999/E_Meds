import 'dart:async';

import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/login_as_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/login_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/doctor_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  bool? checkLogin;
  String? checkType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin = prefs!.getBool("islogin") ?? false;
    checkType = prefs!.getString("type") ?? "Doctor";
    Timer.periodic(
      Duration(seconds: 3),
      (t) {
        if (mounted) {
          gotoWithoutBack(
              context,
              checkLogin == true
                  ? prefs!.getString("type") == "Doctor"
                      ? DoctorMainScreen()
                      : PatientMainScreen()
                  : LoginAsScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boldText("Developed By", 18),
                VSpace(40),
                Image.asset("images/softsols.jpeg"),
                VSpace(40),
                Text(
                  "Digital, AI and Event Management Agency",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 21),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
