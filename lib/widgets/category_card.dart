import 'package:flutter/material.dart';
import 'package:pocket_health/utils/constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x66808080),
                  spreadRadius: 0.5,
                  blurRadius: 4,
                  offset: Offset(0, 1.5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 28,
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Image.asset(icon),
              ),
              backgroundColor: text == "Mental Health"
                  ? Color(0xffd2ffff)
                  : text == "Wellness"
                      ? Color(0xffF2F2C9)
                      : text == "First Aid"
                          ? Color(0xffABDCFF)
                          : text == "Health Insurance"
                              ? Color(0xffD7B4F1)
                              : accentColorLight,
            ),
          ),
          SizedBox(height: 8),
          Text(
            text.contains(" ") ? text.split(" ").first + "\n" + text.split(" ").last : text,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff2E3748),
            ),
          ),
        ],
      ),
    );
  }
}
