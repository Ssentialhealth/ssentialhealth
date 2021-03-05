// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pocket_health/bloc/hotlines/hotlinesBloc.dart';
// import 'package:pocket_health/bloc/hotlines/hotlinesEvent.dart';
// import 'package:pocket_health/bloc/hotlines/hotlinesState.dart';
// import 'package:pocket_health/widgets/hotlines_card.dart';
//
// class AmbulanceHotlines extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE7FFFF),
//       appBar: AppBar(
//         title: Text("Ambulance and Medical"),
//         backgroundColor: Color(0xFF00FFFF),
//         centerTitle: true,
//       ),
//       body: BlocListener<HotlinesBloc,HotlineState>(
//         listener: (context,state){
//           if(state is HotlinesLoading){
//             return Center(child: CircularProgressIndicator());
//           }else if(state is HotlinesLoaded){
//             return HotlinesCard(hotlines: state.props.reversed.toList());
//           }else if(state is HotlinesError){
//             return Container(
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text("Error"),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     CupertinoButton.filled(
//                         child: Text(
//                           "Retry",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         onPressed: () {
//                           BlocProvider.of<HotlinesBloc>(context).add(FetchHotline());
//                         })
//                   ],
//                 ),
//               ),
//             );
//           }else if(state is HotlinesEmpty){
//             return Container();
//           }
//           return Container();
//         },
//       )
//     );
//   }
// }
