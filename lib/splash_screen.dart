import 'dart:async';

import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/login_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/other_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(
      Duration(seconds: 3),
      (t) {
        if (mounted) {
          gotoWithoutBack(context, OtherScreen());
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
                Text(
                  "AGP ZIAUDDIN VIRTUAL CLINIC",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: green),
                ),
                VSpace(30),
                Text(
                  "Emergency Obstetric and Neonatal Care (EmNOC)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,color: red),
                ),
                VSpace(30),
                nAppText("Powered By", 16, grey),
               
                Image.asset("images/agp_logo.jpeg")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
