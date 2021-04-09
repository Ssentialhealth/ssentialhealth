import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem ({
    Key key,
    @required this.image,
    @required this.text,
    @required this.press
  }) : super(key: key);

  final String image, text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.only(left:10,right: 10),
          child: Card(
            color: Color(0xFFFEEEF1),
            child: Row(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Image.asset(image, height: 40,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 20),
                  child: Text( text,style: TextStyle(
                      color: Colors.black,
                      fontSize: 17
                  ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }



}