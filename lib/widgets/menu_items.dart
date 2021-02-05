import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/widget.dart';

class MenuItems extends StatelessWidget{
  const MenuItems({
    Key key, this.image,this.text,this.press,
  }) : super(key: key);
  final String image;
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
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Image.asset(image,scale: 0.8,),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(text,style: mediumTextStyle(),),
              ),
            ],
          ),
        ),
      ),
    );

  }



}
