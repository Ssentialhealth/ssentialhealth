import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/widget.dart';

class AdultUnwellMenuItems extends StatelessWidget{
  const AdultUnwellMenuItems({
    Key key,this.text,this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        child: Column(
          children: [
            Padding(
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
                    child: Icon(Icons.arrow_forward_ios_outlined,color: Color(0xFF00FFFF),size: 18.0,),
                  ),
                ],
              ),
            ),
            Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
          ],
        ),
      ),
    );

  }



}
