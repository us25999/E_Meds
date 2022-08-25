import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class FullImageScreen extends StatefulWidget {
  final String image;
  const FullImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        widget.image,
        width: fullWidth(context),
        height: fullHeight(context),
      ),
    );
  }
}
