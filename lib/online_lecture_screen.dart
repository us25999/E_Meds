import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class OnlineLecture extends StatefulWidget {
  const OnlineLecture({ Key? key }) : super(key: key);

  @override
  State<OnlineLecture> createState() => _OnlineLectureState();
}

class _OnlineLectureState extends State<OnlineLecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Lecture"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: normalText("Hybrid Session on EmNOC, conducted by Prof. Dr. Rubina Hussain, will be held on 15th September 2022 at 10:00 am.The session will be Live here", 17),
      ),
      
    );
  }
}