// import 'package:flutter/material.dart';
//
// class ConditionCardItem extends StatelessWidget {
//   const ConditionCardItem ({
//     Key key,
//     @required this.text,
//   }) : super(key: key);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 90,
//       child: Padding(
//         padding: const EdgeInsets.only(left:10,right: 10),
//         child: Card(
//           color: Colors.white,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5.0),
//                 child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(normalDevelopment.age)
//                 ),
//               ),
//               Divider(color: Color(0xFFC6C6C6),indent: 5,endIndent: 5,),
//               Container(
//                 constraints: BoxConstraints(minHeight: 10.h),
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: normalDevelopment.expectedMilestones.length,
//                     itemBuilder: (BuildContext context,index){
//                       final expectedMilestone = normalDevelopment.expectedMilestones[index];
//                       return Container(
//                           child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text("•"+expectedMilestone)
//
//                           )
//                       );
//                     }
//                 ),
//               )
//
//             ],
//           )
//         ),
//       ),
//     );
//   }
//
//
//
// }