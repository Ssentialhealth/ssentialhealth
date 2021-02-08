import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

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

TextStyle largeTextStyle() {
  return TextStyle(
      color: Colors.black,
      fontSize: 18
  );
}

// Step personalInfo (String _dropDownValue){
//   return Step(
//     title: const Text('Personal '),
//     isActive: false,
//     state: StepState.complete,
//     content: Column(
//       children: <Widget>[
//         TextFormField(
//           decoration: textFieldInputDecoration("Nicolas Dani"),
//         ),
//         SizedBox(height: 8,),
//         TextFormField(
//           decoration: textFieldInputDecoration("Surname"),
//         ),
//         SizedBox(height: 8,),
//         TextFormField(
//           decoration: textFieldInputDecoration("Email"),
//         ),
//         SizedBox(height: 8,),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 alignment: Alignment.centerLeft,
//                 child: CountryListPick(
//                   theme: CountryTheme(
//                       isShowFlag: true,
//                       isShowCode: false,
//                       isShowTitle: false
//                   ),
//                   initialSelection: '+254',
//                   onChanged: (CountryCode code) {
//                     print(code.name);
//                     print(code.code);
//                     print(code.dialCode);
//                     print(code.flagUri);
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(width: 18,),
//             Container(
//               width: 230,
//               child: TextFormField(
//                 decoration: textFieldInputDecoration("Phone Number"),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8,),
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//                 "Others"
//             )
//         ),
//         Divider(color: Color(0xff163C4D)),
//         SizedBox(height: 8,),
//         TextFormField(
//           decoration: textFieldInputDecoration("Date of Birth"),
//         ),
//         SizedBox(height: 8,),
//         DropdownButtonFormField(
//           decoration: textFieldInputDecoration("Gender"),
//           hint: _dropDownValue == null
//               ? Text('')
//               : Text(
//             _dropDownValue,
//             style: TextStyle(color: Colors.black),
//           ),
//           isExpanded: true,
//           iconSize: 30.0,
//           style: TextStyle(color: Colors.black),
//           items: ['Male', 'Female', 'Prefer Not to Say'].map(
//                 (val) {
//               return DropdownMenuItem<String>(
//                 value: val,
//                 child: Text(val),
//               );
//             },
//           ).toList(),
//           onChanged: (val) {
//             setState(
//                   () {
//                 _dropDownValue = val;
//               },
//             );
//           },
//         ),
//         SizedBox(height: 8,),
//         TextFormField(
//           decoration: textFieldInputDecoration("Residence"),
//         ),
//         SizedBox(height: 8,),
//         Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//               borderRadius: BorderRadius.circular(10)
//           ),
//           alignment: Alignment.centerLeft,
//           child: CountryListPick(
//             theme: CountryTheme(
//                 isShowFlag: true
//             ),
//             initialSelection: '+254',
//             onChanged: (CountryCode code) {
//               print(code.name);
//               print(code.code);
//               print(code.dialCode);
//               print(code.flagUri);
//             },
//           ),
//         ),
//
//
//       ],
//     ),
//   );
// }

Step healthInfo (){
  return Step(
    isActive: false,
    state: StepState.editing,
    title: const Text('Health '),
    content: Column(
      children: <Widget>[

      ],
    ),
  );
}

Step otherInfo (){
  return Step(
    state: StepState.editing,
    title: const Text('Other'),
    content: Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Other'),
        ),
      ],
    ),
  );
}






