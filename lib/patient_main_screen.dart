import 'package:agp_ziauddin_virtual_clinic/add_patient_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/doctor_appointment_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/chat_list_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_appointment_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_video_consultation_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/reports_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/training_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/upload_prescription_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/video_consultation_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({Key? key}) : super(key: key);

  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<PatientMainScreen> {
  List screens = [
    UploadPrescriptionScreen(),
    PatientVideoConsultationScreen(),
    ChatListScreen(),
    ReportsScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: green,
        unselectedItemColor: black,
        currentIndex: currentIndex,
        onTap: ((index) {
          currentIndex = index;
          setState(() {});
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.upload,
                size: 30,
              ),
              label: "Report"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.video_camera_front,
                size: 30,
              ),
              label: "Video"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 30,
              ),
              label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: "Prescriptions"),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
