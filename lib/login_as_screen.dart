import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/login_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class LoginAsScreen extends StatefulWidget {
  const LoginAsScreen({Key? key}) : super(key: key);

  @override
  _LoginAsScreenState createState() => _LoginAsScreenState();
}

class _LoginAsScreenState extends State<LoginAsScreen> {
  bool isDoctor = false;
  bool isPatient = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  VSpace(10),
                  Image.asset(
                    "images/agp_logo.jpeg",
                    height: 250,
                  ),

                 
                  // veryBoldText("Login As", 18),
                  // VSpace(30),
                  InkWell(
                    onTap: () {
                      isDoctor = true;
                      isPatient = false;
                      setState(() {});
                    },
                    child: Container(
                      width: fullWidth(context),
                      decoration: BoxDecoration(
                          color: isDoctor ?Colors.cyan : white,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                            child: bAppText("Login as Doctor", 16,
                                isDoctor ? white : black)),
                      ),
                    ),
                  ),
                  VSpace(30),
                  InkWell(
                    onTap: () {
                      isDoctor = false;
                      isPatient = true;
                      setState(() {});
                    },
                    child: Container(
                      width: fullWidth(context),
                      decoration: BoxDecoration(
                          color: isPatient ? Colors.cyan : white,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                            child: bAppText("Login as Patient", 16,
                                isPatient ? white : black)),
                      ),
                    ),
                  ),
                  VSpace(40),
                  PrimaryMaterialButton(context, () {
                    if (isDoctor || isPatient) {
                      prefs!.setString("type", isPatient?"Patient":"Doctor");
                      goto(
                          context,
                          LogInScreen(
                            isPatient: isPatient,
                          ));
                    } else {
                      showWarningDialog(context, "Please Select One");
                    }
                  }, "Continue"),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
