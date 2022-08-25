import 'dart:math';

import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/login_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/doctor_main_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_textfield.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  bool showCPI = false;
  Future signUpWithEmailAndPassword() async {
    setState(() {
      showCPI = true;
    });
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: pswrdController.text);
      User? user = result.user;
      if (user != null) {
        int code = Random().nextInt(1000) + 9000;
        print(code);
        prefs!.setString("id", user.uid);
        prefs!.setString("name", nameController.text);

        prefs!.setString("email", emailController.text);
        prefs!.setString("password", pswrdController.text);
        prefs!.setString("hospital", hospitalController.text);
        prefs!.setString("city", cityController.text);
        prefs!.setInt("code", code);
        prefs!.setBool("islogin", true);
        DatabaseMethods().addUserInfoToDB("doctors", user.uid, {
          "email": emailController.text,
          "name": nameController.text,
          "hospital": hospitalController.text,
          "city": cityController.text,
          "code": code
        }).then((value) {
          goOff(context, DoctorMainScreen());
          showSnackbar(context, "Registration Successfully Welcome to Estate");
        });
      }
    } catch (e) {
      setState(() {
        showCPI = false;
      });
      print(e);
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
              key: signUpKey,
              child: Column(
                children: [
                  VSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Name", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: nameController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                        ],
                        hintText: "Enter Name",
                      ),
                    ],
                  ),
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Hospital", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: hospitalController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                        ],
                        hintText: "Enter Hospital",
                      ),
                    ],
                  ),
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter City", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: cityController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                        ],
                        hintText: "Enter City",
                      ),
                    ],
                  ),
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
                  VSpace(20),
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
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                  VSpace(30),
                  showCPI
                      ? CircularProgressIndicator()
                      : PrimaryMaterialButton(context, () {
                          if (signUpKey.currentState!.validate()) {
                            signUpWithEmailAndPassword();
                          } else {
                            showSnackbar(
                                context, "Please Fill All Fields Correctly");
                          }
                        }, "Sign Up"),
                  VSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      nAppText("You have already an acoount, ", 16, grey),
                      InkWell(
                        onTap: () {
                          if (signUpKey.currentState!.validate()) {
                            signUpWithEmailAndPassword();
                          } else {
                            showSnackbar(
                                context, "Please fill all fields correctly");
                          }
                        },
                        child: Text(
                          "Sign In",
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
