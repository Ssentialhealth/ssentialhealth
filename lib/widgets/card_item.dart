import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.image,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String image, text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Color(0xffFEEEF1),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: 1,
            color: Color(0xffc8c8c8),
          ),
        ),
        animationDuration: Duration(milliseconds: 100),
        child: InkWell(
          onTap: press,
          highlightColor: Color(0x9afeeef1),
          child: Row(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
                  child: Image.asset(
                    image,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Color(0xff2E3748),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
