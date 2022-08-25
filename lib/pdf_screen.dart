import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/view_pdf_screen.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List<String> pdfLinks = [
    "https://pdf.usaid.gov/pdf_docs/PA00JX4C.pdf",
    "https://www.unfpa.org/sites/default/files/pub-pdf/obstetric_monitoring.pdf",
    "https://www.jica.go.jp/project/philippines/0600894/04/pdf/bemoc_guide.pdf"
  ];
  List<String> pdfNames = [
    "BEmNOC",
    "Monitoring Emergency Obstetric Care",
    "Basic Emergency Obstetric Care"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Pdfs")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
            itemCount: pdfLinks.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  goto(context, ViewPdfScreen(url: pdfLinks[index]));
                },
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.picture_as_pdf,
                          color: red,
                          size: 30,
                        ),
                        HSpace(10),
                        Text(
                          pdfNames[index],
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
