import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsBloc.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsEvent.dart';
import 'package:pocket_health/bloc/organs/organsBloc.dart';
import 'package:pocket_health/bloc/organs/organsState.dart';
import 'package:pocket_health/screens/AdultUnwell/organs/organs_list.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';

import 'organDetailsScreen.dart';

class Organs extends StatefulWidget {
  @override
  _OrgansState createState() => _OrgansState();
}

class _OrgansState extends State<Organs> {

  String textValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Main Affected System/Organ",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: BlocBuilder<OrgansBloc,OrgansState>(
          builder: (context,state){
            if(state is OrgansLoaded){

              print(textValue);

              // void filterSearchResults(String query) {
              //   List<String> dummySearchList = List<String>();
              //   dummySearchList.addAll(organsList.name);
              //   if(query.isNotEmpty) {
              //     List<String> dummyListData = List<String>();
              //     dummySearchList.forEach((item) {
              //       if(item.contains(query)) {
              //         dummyListData.add(item);
              //       }
              //     });
              //     setState(() {
              //       items.clear();
              //       items.addAll(dummyListData);
              //     });
              //     return;
              //   } else {
              //     setState(() {
              //       items.clear();
              //       items.addAll(organs);
              //     });
              //   }
              //
              // }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            cursorColor: Colors.grey,
                            decoration: searchFieldInputDecoration("Search main affected organ"),
                            onChanged: (value){
                              setState(() {
                                textValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  textValue == null ?
                  Expanded(
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
                                  BlocProvider.of<OrgansDetailsBloc>(context).add(FetchOrganDetails(id: organs.id));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrganDetailsScreen(title: organs.name,)));

                                },
                              )
                          ),
                        );
                      },
                    ),
                  ) :  Expanded(
                    child:
                   state.organsModel.where((element) => element.name.contains(textValue)).toList().length != 0 ?
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.organsModel.where((element) => element.name.contains(textValue)).toList().length,
                      itemBuilder: (BuildContext context,index){
                        final list = state.organsModel.where((element) => element.name.contains(textValue)).toList();
                        final filterOrgans = list[index];

                        return Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AdultUnwellMenuItems(text: filterOrgans.name,
                                press: ()async{
                                  BlocProvider.of<OrgansDetailsBloc>(context).add(FetchOrganDetails(id: filterOrgans.id));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrganDetailsScreen(title: filterOrgans.name,)));

                                },
                              )
                          ),
                        );
                      },
                    ): Center(child: Text("$textValue Is Not Available"))
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
