import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import '../utils/size_config.dart';

Widget appBarMain(BuildContext buildContext){
  return AppBar(
    title: Text("Ssential App"),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.black)
      ),

  );

}
InputDecoration dateFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      hintText: hintText,
      prefixIcon: Icon(Icons.date_range),
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.black)
      ),

  );

}

InputDecoration dateInputDecoration(String hintText){
  return InputDecoration.collapsed(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black,
      ),

  );

}

InputDecoration lockFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      hintText: hintText,
      prefixIcon: Icon(Icons.lock),
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.black)
      ),

  );

}

InputDecoration inputFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.black),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.black)
    ),

  );

}
InputDecoration inputDeco(String hintText){
  return InputDecoration.collapsed(
    hintText: hintText,

    hintStyle: TextStyle(
      color: Colors.deepOrangeAccent,
    ),
  );

}

InputDecoration searchFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
    hintText: hintText,
    prefixIcon: Icon(Icons.search,color: Colors.grey,),
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Color(0xFF00FFFF)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Color(0xFF00FFFF))
    ),

  );

}

InputDecoration dropDownDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
    hintText: hintText,
    prefixIcon: Icon(Icons.search,color: Colors.grey,),
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Color(0xFF00FFFF)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Color(0xFF00FFFF))
    ),

  );

}

InputDecoration countryFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Color(0xFF00FFFF)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Color(0xFF00FFFF))
    ),

  );

}


BottomNavigationBarItem navBar (Icon icon,String label){
  return BottomNavigationBarItem(
    icon: icon,
    label: label,
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize: 16
  );
}

TextStyle optionStyle =
TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

TextStyle mediumTextStyle() {
  return TextStyle(
      color: Colors.black,
      fontSize: 17
  );
}

CircularProgressIndicator circularProgressIndicator(){
  return CircularProgressIndicator(
    backgroundColor: Colors.black,
    strokeWidth: 10,
  );
}

TextStyle largeTextStyle() {
  return TextStyle(
      color: Colors.black,
      fontSize: 18
  );
}

Divider divider(){
  return Divider(
      height:1,color: Color(0xFFC6C6C6)
  );
}


