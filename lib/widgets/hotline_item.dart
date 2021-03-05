import 'package:flutter/material.dart';

class HotlineItem extends StatelessWidget{
  const HotlineItem({
    Key key,
    @required this.text,
    @required this.press,
}) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 50,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:14.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              )
          ),
        ),
      ),
    );
  }

}