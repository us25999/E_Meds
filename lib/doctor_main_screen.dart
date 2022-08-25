import 'package:agp_ziauddin_virtual_clinic/add_patient_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/doctor_appointment_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/chat_list_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/training_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/video_consultation_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<DoctorMainScreen> {
  List screens = [
    DoctorAppointmentScreen(),
    VideoConsultationScreen(),
    ChatListScreen(),
    TrainingScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goto(context, AddPatientScreen());
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        // backgroundColor: white,
        // selectedLabelStyle: TextStyle(color: mc),
        // unselectedLabelStyle: TextStyle(color: Colors.grey[700]),
        // selectedItemColor: mc,
        // unselectedItemColor: Colors.grey[700],
        // iconSize: 25,
        elevation: 0,
        // currentIndex: currentIndex,
        // onTap: (index) {
        //   setState(() {
        //     currentIndex = index;
        //   });
        // },
        // type: BottomNavigationBarType.fixed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  size: 32,
                  color: currentIndex == 0 ? green : Colors.grey[700],
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.video_camera_front_outlined,
                  size: 32,
                  color: currentIndex == 1 ? green : Colors.grey[700],
                )),
            HSpace(30),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(
                  Icons.chat,
                  size: 27,
                  color: currentIndex == 2 ? green : Colors.grey[700],
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: Icon(
                  Icons.model_training,
                  size: 35,
                  color: currentIndex == 3 ? green : Colors.grey[700],
                )),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
