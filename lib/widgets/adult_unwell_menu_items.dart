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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(text,overflow: TextOverflow.ellipsis,style: mediumTextStyle())),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:5.0),
                  child: Icon(Icons.arrow_forward_ios_outlined,color: Color(0xFF00FFFF),size: 18.0,),
                ),
              ],
            ),
            Divider(color: Color(0xFFC6C6C6),indent: 1,endIndent: 1,),
          ],
        ),
      ),
    );

  }



}
