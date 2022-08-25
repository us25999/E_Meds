import 'package:agp_ziauddin_virtual_clinic/about_us_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/add_patient_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/chat_list_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/online_lecture_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patients_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/pdf_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/quiz_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/splash_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/training_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/video_consultation_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/videos_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<TrainingScreen> {
  GlobalKey<ScaffoldState> dKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
      key: dKey,
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       dKey.currentState!.openDrawer();
      //     },
      //     icon: Icon(
      //       Icons.menu,
      //       size: 30,
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   title: Image.asset(
      //     "images/head.png",
      //     height: 110,
      //     color: grey1,
      //   ),
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName:
      //             normalText(prefs!.getString("name") ?? "Unknown", 20),
      //         accountEmail: Text(prefs!.getString("email") ?? "Unknown"),
      //         currentAccountPicture: CircleAvatar(
      //           child: Icon(
      //             Icons.person,
      //             size: 40,
      //           ),
      //         ),
      //       ),
      //       DrawerItems(Icons.home, "Home", () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.person, "Profile", () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.info, "About Us", () {
      //         goBack(context);
      //         goto(context, AboutUsScreen());
      //       }),
      //       DrawerItems(Icons.privacy_tip, "EmNOC", () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.book_online, "Appointment", () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.video_camera_back_outlined, "Video Consultation",
      //           () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.chat, "Chat", () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.model_training, "Training", () {
      //         goBack(context);
      //       }),
      //       DrawerItems(Icons.pregnant_woman, "Symptom Checker", () async {
      //         goBack(context);
      //         String url =
      //             "https://healthcare-bot-yde7tlccggcwk.azurewebsites.net/";
      //         if (!await launchUrl(Uri.parse(url))) {
      //           throw 'Could not launch $url';
      //         }
      //       }),
      //       DrawerItems(Icons.logout, "Sign Out", () {
      //         prefs!.setBool("islogin", false);
      //         goOff(context, SplashScreen());
      //       }),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  width: fullWidth(context),
                  height: 170,
                  child: Image.asset(
                    "images/head.png",
                    fit: BoxFit.cover,
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     dKey.currentState!.openDrawer();
                //   },
                //   icon: Icon(
                //     Icons.menu,
                //     size: 30,
                //   ),
                // ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Item(Icons.play_circle_fill, "Videos", () {
                            goto(context, VideosScreen());
                          }),
                          Item(Icons.picture_as_pdf, "PDFs", () {
                            goto(context, PdfScreen());
                          }),
                        ],
                      ),
                      VSpace(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Item(Icons.quiz, "Quiz", () {
                            goto(context, QuizScreen());
                          }),
                          Item(Icons.chrome_reader_mode, "Online Lecture",
                              () async {
                            goto(context, OnlineLecture());
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Item(IconData icon, String title, Function fun) {
    return InkWell(
      onTap: () {
        fun();
      },
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: grey2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
              ),
              VSpace(5),
              Text(
                title,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
