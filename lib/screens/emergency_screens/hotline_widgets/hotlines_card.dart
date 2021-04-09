import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesBloc.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesState.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/widgets/hotline_card.dart';

class HotlinesCard extends StatelessWidget {
  // const HotlinesCard({Key key,@required this.hotlines}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotlinesBloc,HotlineState>(
      builder: (context , state){
        if(state is HotlinesInitial){
          return Container(child: Text("Initial"),);
        }if(state is HotlinesLoaded){
          print(state.hotlines.ambulanceAndMedical.length);
          return Container(
            height: 470,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.hotlines.ambulanceAndMedical.length,
              itemBuilder: (BuildContext context,index){
                final ambulance = state.hotlines.ambulanceAndMedical[index];
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hotline(name: ambulance.name, location: ambulance.location,
                      phones: ambulance.phoneNumbers,
                      press: (){
                    },),
                  ),
                );
              },
            ),
          );
        }
        if(state is HotlinesError){
          return Container(child: Text("Error Try Again"),);
        } else{
          return Container(child: CircularProgressIndicator());
        }


      },
    );
  }
  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
