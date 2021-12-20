import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SignaturePad extends StatelessWidget {
  const SignaturePad({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Signature(
      color: Colors.black, // Color of the drawing path
      strokeWidth: 5.0, // with
      backgroundPainter: null, // Additional custom painter to draw stuff like watermark
      onSign: null, // Callback called on user pan drawing
      key: null, // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
    );
  }
}
