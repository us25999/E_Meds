import 'dart:io';

import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/database_methods.dart';
import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadReportScreen extends StatefulWidget {
  const UploadReportScreen({Key? key}) : super(key: key);

  @override
  State<UploadReportScreen> createState() => _UploadPrescriptionScreenState();
}

class _UploadPrescriptionScreenState extends State<UploadReportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var patientsStream;
  int selected = -1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Upload Prescription",
        ),
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
                                                  1,
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
                                    child: isLoading && selected == index
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: white),
                                          )
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
                                                  "Upload Prescription", 16, white)
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
    await FirebaseFirestore.instance.collection("prescriptions").add({
      "image": imageUrl,
      "patient_id": ds.id,
      "doctor_id": prefs!.getString("id")
    });
    showSnackbar(context, "Prescription Uploaded Successfully");
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
