import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPolicyContent extends StatelessWidget {
  final String pdf;
  const ViewPolicyContent({
    Key key,
    this.pdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: SfPdfViewer.network(
              pdf,
              canShowScrollHead: false,
              enableDoubleTapZooming: true,
              initialZoomLevel: 1.0,
              canShowScrollStatus: false,
            ),
          ),
        ),
      ],
    );
  }
}
