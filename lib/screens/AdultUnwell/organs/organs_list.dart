import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/organs/organsBloc.dart';
import 'package:pocket_health/bloc/organs/organsState.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';

class OrgansCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgansBloc,OrgansState>(
        builder: (context,state){
          if(state is OrgansInitial){
            return Container(color: Colors.black,height: 300,);
          }
          if(state is OrgansLoaded){
            return Container(
              height: 470,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.organsModel.length,
                itemBuilder: (BuildContext context,index){
                  final organs = state.organsModel[index];
                  return Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AdultUnwellMenuItems(text: organs.name,
                          press: ()async{
                            // BlocProvider.of<ConditionDetailsBloc>(context).add(FetchDetails(id: accident.id));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ConditionDetailsScreen(title: accident.name,)));

                          },
                        )
                    ),
                  );
                },
              ),
            );
          }
          if(state is OrgansError){
          return Container(color: Colors.blueGrey,height: 40,);
          } else {
            return Container(
                height: 50,
                child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
          }
        }
    );
  }
}
