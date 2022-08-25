import 'package:agp_ziauddin_virtual_clinic/chat_sreen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  bool isLoading = false;
  int selected = -1;
  var patientsStream;
  doOnLaunch() async {
    patientsStream = await DatabaseMethods().getPatients();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doOnLaunch();
  }

  getChatRoomIdById(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Patients"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: patientsStream,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: boldText("No Patients", 16))
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: grey2,
                                        child: Icon(
                                          Icons.person,
                                          size: 35,
                                        ),
                                      ),
                                      HSpace(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              boldText(ds["patient_name"], 19),
                                              HSpace(5),
                                              nAppText(
                                                  ds["patient_gender"] == "M"
                                                      ? "(Male)"
                                                      : "(Female)",
                                                  18,
                                                  grey)
                                            ],
                                          ),
                                          VSpace(3),
                                          normalText(ds["patient_phone"], 16),
                                        ],
                                      ),
                                    ],
                                  ),
                                  VSpace(10),
                                  normalText(
                                      "Medical Issue: " +
                                          ds["patient_medical_issue"],
                                      17),
                                  VSpace(5),
                                  normalText(
                                      "Age: " + ds["patient_age"] + " Years",
                                      17),
                                  VSpace(5),
                                  normalText("City: " + ds["patient_city"], 17),
                                  VSpace(10),
                                  isLoading && selected == index
                                      ? Center(
                                          child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator()))
                                      : BookAndChatButton(ds, index)
                                ],
                              ),
                            ),
                          );
                        }))
                : Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Widget BookAndChatButton(DocumentSnapshot ds, int index) {
    return Row(
      children: [
        // Expanded(
        //   child: MaterialButton(
        //     // minWidth: 90,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //     height: 35,
        //     color: green,
        //     onPressed: () {},
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(
        //           Icons.book_online,
        //           color: white,
        //           size: 20,
        //         ),
        //         HSpace(5),
        //         bAppText("Book", 15, white)
        //       ],
        //     ),
        //   ),
        // ),
        // HSpace(8),
        Expanded(
          child: SizedBox(
            // width: 90,
            height: 35,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                setState(() {
                  isLoading = true;
                  selected = index;
                });

                String chatRoomId =
                    getChatRoomIdById(prefs!.getString("id")!, ds.id);
                print(chatRoomId);
                Map<String, dynamic> chatRoomInfoMap = {
                  "usersEmails": [
                    prefs!.getString("email"),
                    ds["patient_email"]
                  ],
                  "userIds": [prefs!.getString("id"), ds.id],
                  "patient_name": ds["patient_name"],
                  "doctor_name": prefs!.get("name"),
                  "patient_email": ds["patient_email"],
                  "doctor_email": prefs!.getString("email"),
                  "doctor_id": prefs!.getString("id"),
                  "patient_id": ds.id,
                  "ts": DateTime.now()
                };
                DatabaseMethods()
                    .createChatRoom(chatRoomId, chatRoomInfoMap)
                    .then((value) {
                  setState(() {
                    isLoading = false;
                  });
                  goto(
                      context,
                      ChatScreen(prefs!.getString("email"), ds["patient_email"],
                          ds["patient_name"], chatRoomId));
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  HSpace(5),
                  bAppText("Chat", 15, black)
                ],
              ),
            ),
          ),
        ),
        HSpace(8),
        Expanded(
          child: SizedBox(
            // width: 90,
            height: 35,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_camera_front,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  HSpace(5),
                  bAppText("Video", 15, black)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
