import 'package:flutter/material.dart';

class ChildCardItem extends StatelessWidget {
  const ChildCardItem({Key key, @required this.image, @required this.press}) : super(key: key);

  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              image,
              height: 70,
            ),
          ),
        ),
      ),
    );
  }
}
