import 'package:agp_ziauddin_virtual_clinic/quiz_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({ Key? key }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Result"),
      ),
      body: Container(
        child: Center(
          child: normalText("Your Score is "+result.toString()+" /16",30),
        ),
      ),
      
    );
  }
}