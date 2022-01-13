import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends StatelessWidget {
  final String pdf;
  final String pdfTitle;

  const PdfViewPage({
    Key key,
    this.pdfTitle,
    this.pdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(pdf);
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
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: SfPdfViewer.network(
                  pdf,
                  canShowScrollHead: false,
                  canShowScrollStatus: false,
                  onDocumentLoaded: (details) async {
                    await Permission.storage.request();
                    final List<int> bytes = details.document.save();
                    final path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                    final file = await File(path + '/$pdfTitle.pdf').writeAsBytes(bytes);
                    print(file.absolute.path);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
