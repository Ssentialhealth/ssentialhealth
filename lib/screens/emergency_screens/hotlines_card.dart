import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Container(color: Colors.black,height: 300,);
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
                    child: Hotline(name: ambulance.name, location: ambulance.location, phone: ambulance.phoneNumbers[0]),
                  ),
                );
              },
            ),
          );
        }
        if(state is HotlinesError){
          return Container(color: Colors.blueGrey,height: 40,);
        } else{
          return Container(color: Colors.red,height: 40,);
        }
      },
    );
  }
}
