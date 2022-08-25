import 'package:agp_ziauddin_virtual_clinic/chat_sreen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<ChatListScreen> {
  bool isLoading = false;
  int selected = -1;
  var chatStream;
  doOnLaunch() async {
    chatStream = await DatabaseMethods().getChatroom();
    setState(() {});
  }

  getChatRoomIdById(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
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
      appBar: AppBar(
        elevation: 0,
        title: Text("Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: chatStream,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: boldText("No Chats", 16))
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
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isLoading = true;
                                        selected = index;
                                      });

                                      String chatRoomId = getChatRoomIdById(
                                          prefs!.getString("id")!,
                                          prefs!.getString("type") == "Doctor"
                                              ? ds["patient_id"]
                                              : ds["doctor_id"]);

                                      goto(
                                          context,
                                          ChatScreen(
                                              prefs!.getString("email"),
                                              prefs!.getString("type") ==
                                                      "Doctor"
                                                  ? ds["patient_email"]
                                                  : ds["doctor_email"],
                                              prefs!.getString("type") ==
                                                      "Doctor"
                                                  ? ds["patient_name"]
                                                  : ds["doctor_name"],
                                              chatRoomId));
                                      ;
                                    },
                                    child: Row(
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
                                            boldText(
                                                prefs!.getString("type") ==
                                                        "Doctor"
                                                    ? ds["patient_name"]
                                                    : ds["doctor_name"],
                                                19),
                                            VSpace(3),
                                            normalText(
                                                prefs!.getString("type") ==
                                                        "Doctor"
                                                    ? ds["patient_email"]
                                                    : ds["doctor_email"],
                                                16),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  VSpace(10),

                                  // MaterialButton(
                                  //   // minWidth: 90,
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(10)),
                                  //   height: 40,
                                  //   color: Colors.cyan,
                                  //   onPressed: () {

                                  //   },
                                  //   child: selected == index && isLoading
                                  //       ? Center(
                                  //           child: CircularProgressIndicator(color: white,))
                                  //       : Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.center,
                                  //           children: [
                                  //             Icon(
                                  //               Icons.chat,
                                  //               color: white,
                                  //               size: 23,
                                  //             ),
                                  //             HSpace(5),
                                  //             bAppText("Chat", 17, white)
                                  //           ],
                                  //         ),
                                  // ),
                                ],
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
