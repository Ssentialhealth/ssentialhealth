import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class Hotline extends StatelessWidget {
  const Hotline({
    Key key,
    @required this.name,
    @required this.location,
    @required this.phone,
    @required this.press,
  }) : super(key:key);
  final String name;
  final String location;
  final String phone;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(name,style: TextStyle(fontSize: 14),)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(location)),
                ),
              ),
            ],
          ),
          GestureDetector(
           onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(phone,style: TextStyle(color: Colors.blue),)),
            ),
          ),
        ],
      ),
    );
  }


}

