import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellBloc.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellState.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsBloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsEvent.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsBloc.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsState.dart';
import 'package:pocket_health/screens/AdultUnwell/condition_details/conditionDetailsScreen.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';

class OrganDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgansDetailsBloc,OrganDetailsState>(
      builder: (context , state){
        if(state is OrganDetailsInitial){
          return Container(color: Colors.black,height: 300,);
        }
        if(state is OrganDetailsLoaded){
          return Container(
            height: 470,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.organDetailsModel.possibleConditions.length,
              itemBuilder: (BuildContext context,index){
                final accident = state.organDetailsModel.possibleConditions[index];
                return Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AdultUnwellMenuItems(text: accident.name,
                        press: ()async{
                          BlocProvider.of<ConditionDetailsBloc>(context).add(FetchDetails(id: accident.id));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ConditionDetailsScreen(title: accident.name,)));

                        },
                      )
                  ),
                );
              },
            ),
          );
        }
        if(state is AdultUnwellError){
          return Container(color: Colors.blueGrey,height: 40,);
        } else{
          return Container(
              height: 50,
              child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
        }
      },
    );
  }
}