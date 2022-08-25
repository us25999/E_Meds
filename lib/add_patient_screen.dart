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

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreen();
}

class _AddPatientScreen extends State<AddPatientScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController medicalIssueController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool showCPI = false;
  String selectedGender = "M";
  String selectedSatus = "A";
  Future signUpWithEmailAndPassword() async {
    setState(() {
      showCPI = true;
    });
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: pswrdController.text);
      User? user = result.user;
      if (user != null) {
        print(prefs!..getInt("code"));
        DatabaseMethods().addUserInfoToDB("patients", user.uid, {
          "patient_id": user.uid,
          "patient_email": emailController.text,
          "patient_name": nameController.text,
          "patient_phone": phoneController.text,
          "patient_city": cityController.text,
          "patient_age": ageController.text,
          "patient_medical_issue": medicalIssueController.text,
          "patient_gender": selectedGender,
          "doctor_email": prefs!.getString("email"),
          "doctor_name": prefs!.getString("name"),
          "doctor_hospital": prefs!.getString("hospital"),
          "doctor_city": prefs!.getString("city"),
          "code": prefs!.getInt("code")
        }).then((value) {
          goBack(context);
          showSnackbar(context, "Patient Added Successfully");
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
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Patient"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: key,
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
                      boldText("Enter Age", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: ageController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                        ],
                        hintText: "Enter Age",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  VSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boldText("Select Gender", 16),
                      Row(
                        children: [
                          Radio(
                            value: "M",
                            groupValue: selectedGender,
                            onChanged: (val) {
                              selectedGender = "M";
                              setState(() {});
                            },
                          ),
                          HSpace(5),
                          normalText("Male", 16)
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "F",
                                groupValue: selectedGender,
                                onChanged: (val) {
                                  selectedGender = "F";
                                  setState(() {});
                                },
                              ),
                              HSpace(5),
                              normalText("Female", 16)
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Phone", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: phoneController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                        ],
                        hintText: "EnterPhone",
                        keyboardType: TextInputType.phone,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boldText("Marital Status", 16),
                      Row(
                        children: [
                          Radio(
                            value: "A",
                            groupValue: selectedSatus,
                            onChanged: (val) {
                              selectedSatus = "A";
                              setState(() {});
                            },
                          ),
                          HSpace(2),
                          normalText("Married", 16)
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "B",
                                groupValue: selectedSatus,
                                onChanged: (val) {
                                  selectedSatus = "B";
                                  setState(() {});
                                },
                              ),
                              HSpace(2),
                              normalText("Unmarried", 16)
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Number of Children", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: childrenController,
                        validators: [],
                        hintText: "Enter Children",
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Email Address(Optional)", 16),
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
                      boldText("Enter Password(Optional)", 16),
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
                  VSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Enter Medical Issue", 16),
                      VSpace(10),
                      CustomTextField(
                        controller: medicalIssueController,
                        validators: [
                          RequiredValidator(
                              errorText: "This Field is Required"),
                        ],
                        hintText: "Enter Medical Issue",
                      ),
                    ],
                  ),
                  VSpace(20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: MaterialButton(
            minWidth: fullWidth(context),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            height: 45,
            color: mc,
            onPressed: () {
              if (key.currentState!.validate()) {
                signUpWithEmailAndPassword();
              } else {
                showSnackbar(context, "Please Fill All Fields Correctly");
              }
            },
            child: showCPI
                ? CircularProgressIndicator(
                    color: white,
                  )
                : Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
          )),
    );
  }
}
