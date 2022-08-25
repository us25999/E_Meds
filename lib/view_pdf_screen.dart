import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewPdfScreen extends StatelessWidget {
  final String url;
  const ViewPdfScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: PDF().cachedFromUrl(
        //   'https://www.fluttercampus.com/sample.pdf',
        //   maxAgeCacheObject: Duration(days: 30), //duration of cache
        //   placeholder: (progress) => Center(child: Text('Loading....')),
        //   errorWidget: (error) => Center(child: Text("Something Went Wrong")),
        // ),
        );
  }
}
