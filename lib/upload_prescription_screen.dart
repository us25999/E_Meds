import 'dart:io';

import 'package:agp_ziauddin_virtual_clinic/about_us_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_appointment_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/patient_video_consultation_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/splash_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<UploadPrescriptionScreen> createState() =>
      _UploadPrescriptionScreenState();
}

class _UploadPrescriptionScreenState extends State<UploadPrescriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> dKey = GlobalKey<ScaffoldState>();
  var doctorsStream;
  int selected = -1;

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
      key: dKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              dKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 30,
            )),
        title: Text("Upload Report")
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  normalText(prefs!.getString("name") ?? "Unknown", 20),
              accountEmail: Text(prefs!.getString("email") ?? "Unknown"),
              currentAccountPicture: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),
            DrawerItems(Icons.home, "Home", () {
              goBack(context);
            }),
            DrawerItems(Icons.person, "Profile", () {
              goBack(context);
            }),
            DrawerItems(Icons.info, "About Us", () {
              goBack(context);
              goto(context, AboutUsScreen());
            }),
           
            DrawerItems(Icons.book_online, "Appointment", () {
              goBack(context);
              goto(context, PatientAppointmentScreen());
            }),
            DrawerItems(Icons.video_camera_back_outlined, "Video Consultation",
                () {
              goBack(context);
              goto(context, PatientVideoConsultationScreen());
            }),
            // DrawerItems(Icons.chat, "Chat", () {
            //   goBack(context);
            // }),

            DrawerItems(Icons.logout, "Sign Out", () {
              prefs!.setBool("islogin", false);
              goOff(context, SplashScreen());
            }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: doctorsStream,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: boldText("No Doctor", 16))
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
                                      selected = index;
                                      takeImage(ds);
                                    },
                                    child: selected == index && isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: white))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .video_camera_front_outlined,
                                                color: white,
                                                size: 23,
                                              ),
                                              HSpace(5),
                                              bAppText(
                                                  "Upload Report", 16, white)
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

  bool isLoading = false;
  String? imageUrl;
  Future imageUpload(DocumentSnapshot ds) async {
    setState(() {
      isLoading = true;
    });
    var imageName = image!.path.split('/').last;
    print(imageName);
    if (image == null) return;
    var imageStatus = await FirebaseStorage.instance
        .ref()
        .child('imageFile/$imageName')
        .putFile(image!);
    imageUrl = await imageStatus.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("reports").add({
      "image": imageUrl,
      "doctor_id": ds.id,
      "patient_id": prefs!.getString("id")
    });
    showSnackbar(context, "Report Uploaded Successfully");
    setState(() {
      isLoading = false;
    });
  }

  File? image;
  bool isImageSelected = false;
  final ImagePicker picker = new ImagePicker();

  // List<String> imagesList = [];

  Future getImageFromGallery(DocumentSnapshot ds) async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        // imagesList.add(image!);
        imageUpload(ds);
        isImageSelected = true;
      } else {
        print("no image selected");
      }
    });
  }

  Future captureImageFromCamera(DocumentSnapshot ds) async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        // imagesList.add(image!);
        imageUpload(ds);
        isImageSelected = true;
      } else {
        print("no image selected");
      }
    });
  }

  takeImage(DocumentSnapshot ds) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Select any option",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  getImageFromGallery(ds);
                }),
            SimpleDialogOption(
                child: Text(
                  "Capture Image from Camera",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  captureImageFromCamera(ds);
                }),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                goBack(context);
              },
            ),
          ],
        );
      },
    );
  }
}
