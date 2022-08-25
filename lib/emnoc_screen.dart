import 'package:agp_ziauddin_virtual_clinic/widgets/custom_textfield.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EMNOCScreen extends StatefulWidget {
  const EMNOCScreen({Key? key}) : super(key: key);

  @override
  State<EMNOCScreen> createState() => _EMNOCScreenState();
}

class _EMNOCScreenState extends State<EMNOCScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pmdcController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EmNOC"),
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                boldText("Emergency Obstetric and Neonatal Care (EmNOC) ", 18),
                normalText("""
               
The main objective is to save life of women and children during pregnancy and labour in remote areas of Sindh Province where medical facilities are not available in sufficient manners.
          
• Emergencies in Labor and Delivery
• Neonatal Care
• Postnatal Care
• Post-abortion Care
          
          """, 17),
                boldText("The  dates for 87th EMNOC workshop are  8th,9th and 10th of September 2022 Regards", 18),
                VSpace(20),
                CustomTextField(
                  controller: nameController,
                  validators: [],
                  hintText: "Name",
                ),
                VSpace(10),
                CustomTextField(
                  controller: hospitalController,
                  validators: [],
                  hintText: "Hospital",
                ),
                VSpace(10),
                CustomTextField(
                  controller: emailController,
                  validators: [],
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                VSpace(10),
                CustomTextField(
                  controller: phoneController,
                  validators: [],
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                ),
                VSpace(20),
                CustomTextField(
                  controller: pmdcController,
                  validators: [],
                  hintText: "PMDC Number",
                ),
                VSpace(20),
                PrimaryMaterialButton(context, () {
                  final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'cme.desk@zu.edu.pk,kashiffareed01@gmail.com',
                      queryParameters: {
                        'subject':"Registration",
                        'body': """Name:${nameController.text}Email:${emailController.text}Phone:${phoneController.text}PDMC NUmber:${pmdcController.text}Hospital:${hospitalController.text}"""
                      });

                  launch(emailLaunchUri.toString());
                }, "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
