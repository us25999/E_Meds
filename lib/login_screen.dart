import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/doctor_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/signup_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_textfield.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LogInScreen extends StatefulWidget {
  final bool isPatient;
  const LogInScreen({Key? key, required this.isPatient}) : super(key: key);

  @override
  State<LogInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool showCPI = false;
  signInWithEmailAndPassword() async {
    setState(() {
      showCPI = true;
    });
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: pswrdController.text);
      User? user = result.user;

      if (user != null) {
        try {
          prefs!.setString("id", user.uid);

          prefs!.setString("email", emailController.text);
          prefs!.setString("password", pswrdController.text);

          prefs!.setBool("islogin", true);
          goOff(context,
              widget.isPatient ? PatientMainScreen() : DoctorMainScreen());
          showSnackbar(context, "Login Successfully Welcome to AppR");
        } catch (e) {
          setState(() {
            showCPI = false;
          });

          showSnackbar(context, e.toString());
        }
      }
    } catch (e) {
      setState(() {
        showCPI = false;
      });
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: loginKey,
              child: Column(
                children: [
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Email Address", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: emailController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                          EmailValidator(errorText: "This is not a valid email")
                        ],
                        hintText: "Enter Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                  VSpace(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Password", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: pswrdController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                          MinLengthValidator(6,
                              errorText: "Password should be atleast 6 digits")
                        ],
                        hintText: "Enter Password",
                        isPassword: true,
                      ),
                    ],
                  ),
                  // VSpace(30),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Text(
                  //         "Forgot Password",
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             decoration: TextDecoration.underline),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Text(
                  //         "Change Password",
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             decoration: TextDecoration.underline),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  VSpace(40),
                  showCPI
                      ? CircularProgressIndicator()
                      : PrimaryMaterialButton(context, () {
                          if (loginKey.currentState!.validate()) {
                            signInWithEmailAndPassword();
                          } else {
                            showSnackbar(context, "Fill All Fields Correctly");
                          }
                        }, "Sign In"),
                  VSpace(20),
                  widget.isPatient
                      ? InkWell(
                          onTap: () {
                            goOff(context, PatientMainScreen());
                          },
                          child: Text(
                            "Login as a Guest",
                            style: TextStyle(
                                fontSize: 17,
                                color: green,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            nAppText("You have not acoount , ", 16, grey),
                            InkWell(
                              onTap: () {
                                gotoWithoutBack(context, SignUpScreen());
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: grey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
