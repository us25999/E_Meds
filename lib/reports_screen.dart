import 'package:agp_ziauddin_virtual_clinic/about_us_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/full_image_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_appointment_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_video_consultation_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/splash_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  GlobalKey<ScaffoldState> dKey = GlobalKey<ScaffoldState>();
  var reportsStream;

  doOnLaunch() async {
    reportsStream = await DatabaseMethods().getPatientReports();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: dKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          prefs!.getString("type") == "Doctor"
              ? "Reports"
              : "Prescriptions",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: reportsStream,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(
                        child: boldText(
                            prefs!.getString("type") == "Doctor"
                                ? "No Reports"
                                : "No Prexcriptions",
                            16))
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Card(
                            color: white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: grey2!)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: () {
                                  goto(context,
                                      FullImageScreen(image: ds["image"]));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      ds["image"],
                                      width: fullWidth(context),
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 30,
                                    //       backgroundColor: grey2,
                                    //       child: Icon(
                                    //         Icons.person,
                                    //         size: 35,
                                    //       ),
                                    //     ),
                                    //     HSpace(10),
                                    //     Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         boldText(ds["name"], 19),
                                    //         VSpace(3),
                                    //         normalText(ds["email"], 16),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    // VSpace(10),
                                    // normalText(
                                    //     "From " +
                                    //         ds["hospital"] +
                                    //         " Hospital At " +
                                    //         ds["city"],
                                    //     17),
                                    // VSpace(10),
                                    // MaterialButton(
                                    //   // minWidth: 90,
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10)),
                                    //   height: 40,
                                    //   color: green,
                                    //   onPressed: () {},
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Icon(
                                    //         Icons.video_camera_front_outlined,
                                    //         color: white,
                                    //         size: 23,
                                    //       ),
                                    //       HSpace(5),
                                    //       bAppText(
                                    //           "Video Consultation", 16, white)
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))
                : Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
