import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              VSpace(10),
              CircleAvatar(
                radius: 60,
                backgroundColor: grey2,
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),
              VSpace(40),
              Item("Name", prefs!.getString("name"), true, "name"),
              Item("Email", prefs!.getString("email"), false, "email"),
              Item("Hospital", prefs!.getString("hospital"), true, "hospital")
            ],
          ),
        ),
      ),
    );
  }

  Widget Item(String title, String? value, bool isEdited, String field) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldText(title, 16),
          VSpace(10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: grey2),
            width: fullWidth(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  normalText(value ?? "Unknown", 16),
                  InkWell(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return EditDialog(field);
                            });
                      },
                      child: isEdited ? Icon(Icons.edit) : SizedBox())
                ],
              ),
            ),
          ),
          VSpace(20),
        ],
      ),
    );
  }

  Widget EditDialog(String field) {
    return AlertDialog(
      title: Text("Enter"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              goBack(context);
            },
            child: Text("No")),
        TextButton(
            onPressed: () async {
              prefs!.setString(field, controller.text);
              setState(() {});
              // await FirebaseFirestore.instance
              //     .collection("doctors")
              //     .doc(prefs!.getString("id"))
              //     .update({field: controller.text});
              goBack(context);
              showSnackbar(context, "Edited Successfully");
              controller.text = "";
            },
            child: Text("Yes")),
      ],
    );
  }
}
