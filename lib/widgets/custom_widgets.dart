import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration boxDecoration(Color color) {
  return BoxDecoration(
    color: color,
    border: Border.all(width: 1, color: grey),
    borderRadius: BorderRadius.circular(10),
  );
}

BoxDecoration boxDecoration1(Color color, double radius) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );
}

BoxDecoration gboxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.grey, Colors.green],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 1.8, color: Colors.black),
      borderRadius: BorderRadius.circular(10));
}

TextStyle ntextStyle(double size, Color color) {
  return TextStyle(
    color: color,
    fontSize: size,
  );
}

TextStyle bTextStyle(double size, Color color) {
  return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold);
}

goto(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

gotoc(BuildContext context, Widget nextScreen) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => nextScreen));
}

gotoWithoutBack(BuildContext context, Widget nextScreen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => nextScreen));
}

goBack(BuildContext context) {
  Navigator.of(context).pop();
}

goOff(BuildContext context, Widget nextScreen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => nextScreen), (route) => false);
}

Widget BackButtonW(BuildContext context, IconData icon) {
  return IconButton(
      onPressed: () {
        goBack(context);
      },
      icon: Icon(
        icon,
        size: 18,
        color: black,
      ));
}

Widget normalText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
    ),
  );
}

Widget boldText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget veryBoldText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.w900),
    textAlign: TextAlign.center,
  );
}

Widget nAppText(String text, double size, Color? color) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size),
  );
}

Widget bAppText(String text, double size, Color? color) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
  );
}

Widget PrimaryMaterialButton(
    BuildContext context, Function fun, String buttonText) {
  return MaterialButton(
    minWidth: fullWidth(context),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    height: 45,
    color: mc,
    onPressed: () {
      fun();
    },
    child: Text(
      buttonText,
      style: TextStyle(color: Colors.white, fontSize: 17),
    ),
  );
}

Widget SecondaryMaterialButton(Function fun, String buttonText, Color? color,
    double width, Color? textColor) {
  return MaterialButton(
    minWidth: width,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    height: 40,
    color: color,
    onPressed: () {
      fun();
    },
    child: Text(
      buttonText,
      style: TextStyle(color: textColor, fontSize: 14),
    ),
  );
}

Widget PrimaryOutlineButton(Function fun, String buttonText, double width) {
  return SizedBox(
    width: 150,
    height: 40,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        fun();
      },
      child: nAppText(buttonText, 12, white),
    ),
  );
}

// showToast(String msg) {
//   Fluttertoast.showToast(msg: msg, backgroundColor: white, textColor: black);
// }

showWarningDialog(BuildContext context, String content) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  goBack(context);
                },
                child: Text("Ok"))
          ],
        );
      });
}

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: grey1,
    margin: EdgeInsets.all(15),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    content: nAppText(content, 15, Colors.black),
  ));
}

Widget DrawerItems(IconData icon, String title, Function fun) {
  return InkWell(
    onTap: () {
      fun();
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.grey[700],
                  ),
                  HSpace(20),
                  bAppText(title, 17, black),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.brown,
              )
            ],
          ),
        ),
        Divider(),
      ],
    ),
  );
}

Widget VSpace(double h) {
  return SizedBox(
    height: h,
  );
}

Widget HSpace(double w) {
  return SizedBox(
    width: w,
  );
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget VerticalListTile(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      boldText(title, 16),
      VSpace(5),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: normalText(content, 17),
        ),
      )
    ],
  );
}

Widget DefaultImage(double w, double h) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: grey3,
    ),
    width: w,
    height: h,
  );
}

Widget BestSellerItem(
    BuildContext context, String name, int price, Color color) {
  return InkWell(
    onTap: () {
      // goto(context, ProductDetailScreen2(name: name, price: price));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 150,
              height: 170,
              color: white,
            ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  // bottomLeft: Radius.circular(20),
                  // topRight: Radius.circular(10),
                ),
                color: color,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: nAppText("\$" + price.toString(), 14, white),
                ),
              ),
            )
          ],
        ),
        VSpace(10),
        normalText(name, 17)
      ],
    ),
  );
}

Widget AppName(double size, bool isDark) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundColor: mc,
        radius: size - 5,
        child: bAppText("AI", size, white),
      ),
      bAppText("haram", size, isDark ? white : black)
    ],
  );
}

void showSuccessAlertDialog(
    BuildContext context, String title, String btnText) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: mc,
                  radius: 40,
                  child: Icon(
                    Icons.done,
                    size: 50,
                    color: white,
                  ),
                ),
                VSpace(25),
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                VSpace(25),
                PrimaryMaterialButton(context, () {}, btnText)
              ],
            ),
          ),
        );
      });
}

PreferredSizeWidget CustomAppBar(BuildContext context) {
  return AppBar(
    leadingWidth: 0,
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Image.asset(
      "images/head.png",
      height: 110,
      color: grey1,
    ),
  );
}

Widget ContainerWithBorder(String text, Color color) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: nAppText(text, 15, color),
    ),
  );
}
