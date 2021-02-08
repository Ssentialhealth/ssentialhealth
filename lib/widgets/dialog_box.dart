import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/widget.dart';

class DialogBox extends StatelessWidget{
  const DialogBox ({
    Key key,
    @required this.email,
    @required this.feedback,
    @required this.press,
 }) : super(key: key);
  final String email;
  final String feedback;
  final Function press;

  @override
  Widget build(BuildContext context) {

  }



}