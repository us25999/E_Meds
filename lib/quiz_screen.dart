import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/quiz_model.dart';
import 'package:agp_ziauddin_virtual_clinic/result_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

int result = 0;

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                boldText(quiz[i].q, 18),
                VSpace(40),
                answer(quiz[i].a, 0),
                VSpace(15),
                answer(quiz[i].b, 1),
                VSpace(15),
                answer(quiz[i].c, 2),
                VSpace(15),
                answer(quiz[i].d, 3),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: i == quiz.length - 1
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryMaterialButton(
                context,
                () {
                  setState(() {
                    isPressed = false;
                    selected = -1;
                    flag = false;
                    if (i <= quiz.length - 2) {
                      i++;
                      if (i == quiz.length - 1) {
                        gotoWithoutBack(context, ResultScreen());
                      }
                    }
                  });
                },
                "Next",
              ),
            ),
    );
  }

  bool isPressed = false;
  int selected = -1;
  bool flag = false;
  Widget answer(String text, int index) {
    return InkWell(
      onTap: isPressed
          ? null
          : () {
              isPressed = true;
              selected = index;
              if (quiz[i].e == text) {
                flag = true;
                result=result+1;
                
              }
              print(result);
             
              setState(() {});
            },
      child: Container(
        width: fullWidth(context),
        decoration: BoxDecoration(
            color: (isPressed && selected == index)
                ? flag
                    ? green
                    : red
                : white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: nAppText(
            text,
            17,
            (isPressed && selected == index)
                ? flag
                    ? white
                    : white
                : black,
          )),
        ),
      ),
    );
  }
}
