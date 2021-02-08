import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/widget.dart';

class FeedbackItems extends StatelessWidget{
  const FeedbackItems({
    Key key,
    @required this.text ,
    @required this.press,
}) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        child: Padding(
          padding:  EdgeInsets.only(left:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(text,style: mediumTextStyle(),),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }



}