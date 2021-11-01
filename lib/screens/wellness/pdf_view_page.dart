import 'package:flutter/material.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends StatelessWidget {
  final String pdf;
  const PdfViewPage({Key key, this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "View PDF",
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: Container(
          height: 1000,
          child: SfPdfViewer.network(
            pdf,
            canShowScrollHead: false,
            canShowScrollStatus: false,
          ),
        ),
      ),
    );
  }
}
