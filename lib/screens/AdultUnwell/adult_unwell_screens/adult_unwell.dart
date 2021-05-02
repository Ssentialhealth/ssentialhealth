import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellBloc.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellEvent.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellState.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailState.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsBloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsEvent.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsEvent.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_bloc.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_event.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_state.dart';
import 'package:pocket_health/models/adult_unwell_model.dart';
import 'package:pocket_health/screens/AdultUnwell/adult_unwell_screens/adult_unwell_list.dart';
import 'package:pocket_health/screens/AdultUnwell/condition_details/conditionDetailsScreen.dart';
import 'package:pocket_health/screens/AdultUnwell/organs/organs.dart';
import 'package:pocket_health/screens/doctor_consult/doctor_consult_screen.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';

class AdultUnwell extends StatefulWidget {
  @override
  _AdultUnwellState createState() => _AdultUnwellState();
}

class _AdultUnwellState extends State<AdultUnwell> {

  String textValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Most Notable Symptom/Sign",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: BlocBuilder<AdultUnwellBloc,AdultUnwellState>(
            builder: (context,state){
                           if(state is AdultUnwellLoaded){
                print(textValue);
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              cursorColor: Colors.grey,
                              decoration: searchFieldInputDecoration("Search symptom or condition"),
                              onChanged: (value){
                                setState(() {
                                  textValue = value;
                                  BlocProvider.of<SearchConditionBloc>(context).add(FetchSearchCondition(condition: textValue));
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Organs()));

                              },
                              child: Icon(Icons.menu,size: 32.0)
                          ),
                        ),
                      ],
                    ),
                    textValue == null ?
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.adultUnwellModel.length,
                        itemBuilder: (BuildContext context,index){
                          final organs = state.adultUnwellModel[index];


                          return Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AdultUnwellMenuItems(text: organs.name,
                                  press: ()async{
                                    BlocProvider.of<ConditionDetailsBloc>(context).add(FetchDetails(id: organs.id));
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConditionDetailsScreen(title: organs.name,)));

                                  },
                                )
                            ),
                          );
                        },
                      ),
                    ) :  BlocBuilder<SearchConditionBloc,SearchConditionState>(
                      builder: (context,state){
                        if(state is SearchConditionLoaded ){
                          return Expanded(
                              child: state.searchCondition.length == null ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.searchCondition.length,
                                itemBuilder: (BuildContext context,index){
                                  final search = state.searchCondition[index];

                                  return Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AdultUnwellMenuItems(text: search.name,
                                          press: ()async{
                                            BlocProvider.of<ConditionDetailsBloc>(context).add(FetchDetails(id: search.id));
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ConditionDetailsScreen(title: search.name,)));

                                          },
                                        )
                                    ),
                                  );
                                },
                              ):Padding(
                                padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 8.0),
                                child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                        child: Text("Sorry,$textValue did not match any condition in our Database, please refine your search or",textAlign: TextAlign.center,)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: ()async{
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorConsultScreen()));

                                          },
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(" Consult a doctor",style: TextStyle(color:Colors.lightBlueAccent),textAlign: TextAlign.center,)),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text(" or a facility for further help",style: TextStyle(color:Colors.lightBlueAccent))),
                                      ],
                                    ),

                                  ],
                                )),
                              )
                          );
                        }
                        if(state is SearchConditionLoading){
                          return Center(
                            child: Container(
                                child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)
                            ),
                          );
                        }
                        return Center(child: Text("$textValue Is Not Available"));
                      },
                    )

                  ],
                );
              }
              return Center(
                child: Container(
                  child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)
                ),
              );
            }



        ),
      ),
    );
  }
}





































