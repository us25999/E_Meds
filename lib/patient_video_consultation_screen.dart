import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/video_call_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientVideoConsultationScreen extends StatefulWidget {
  const PatientVideoConsultationScreen({Key? key}) : super(key: key);

  @override
  State<PatientVideoConsultationScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientVideoConsultationScreen> {
  var doctorsStream;
  final _channelController = TextEditingController();
  bool _validateError = false;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  doOnLaunch() async {
    doctorsStream = await DatabaseMethods().getDoctors();
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
      appBar: AppBar(
        elevation: 0,
        title: Text("Video Consultation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: doctorsStream,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: boldText("No Video Consultation", 16))
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
                                          boldText(ds["name"], 19),
                                          VSpace(3),
                                          normalText(ds["email"], 16),
                                        ],
                                      ),
                                    ],
                                  ),
                                  VSpace(10),
                                  normalText(
                                      "From " +
                                          ds["hospital"] +
                                          " Hospital At " +
                                          ds["city"],
                                      17),
                                  VSpace(10),
                                  MaterialButton(
                                    // minWidth: 90,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 40,
                                    color: green,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ChannelNameDialog(int.parse(
                                                ds["code"].toString()));
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.video_camera_front_outlined,
                                          color: white,
                                          size: 23,
                                        ),
                                        HSpace(5),
                                        bAppText(
                                            "Video Consultation", 16, white)
                                      ],
                                    ),
                                  ),
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

  Widget ChannelNameDialog(int code) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: boldText("Enter ${code.toString()} to Join", 17),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 20),
          child: TextField(
            controller: _channelController,
            decoration: InputDecoration(
              errorText: _validateError ? 'Code is mandatory' : null,
              hintStyle: TextStyle(fontSize: 14),
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
              hintText: "Enter ${code.toString()} to Join",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  onPressed: onJoin,
                  child: Text('Join'),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Future<void> onJoin() async {
    goBack(context);
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCallScreen(
            channelName: _channelController.text,
          ),
        ),
      );
      _channelController.text = "";
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
