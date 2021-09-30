import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsBloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsEvent.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsBloc.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsEvent.dart';
import 'package:pocket_health/bloc/organs/organsBloc.dart';
import 'package:pocket_health/bloc/organs/organsState.dart';
import 'package:pocket_health/bloc/search_organ/search_organ_bloc.dart';
import 'package:pocket_health/bloc/search_organ/search_organ_event.dart';
import 'package:pocket_health/bloc/search_organ/search_organ_state.dart';
import 'package:pocket_health/screens/AdultUnwell/condition_details/conditionDetailsScreen.dart';
import 'package:pocket_health/screens/doctor_consult/doctor_consult.dart';
import 'package:pocket_health/screens/facilities/facilities_categories_screen.dart';
import 'package:pocket_health/utils/constants.dart';
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
        title: Text(
          "Main Affected System/Organ",
          style: appBarStyle,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: Container(
        child: BlocBuilder<OrgansBloc, OrgansState>(
          builder: (context, state) {
            if (state is OrgansLoaded) {
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
                            decoration: searchFieldInputDecoration("Search main affected organ"),
                            onChanged: (value) {
                              setState(() {
                                textValue = value;
                                BlocProvider.of<SearchOrganBloc>(context).add(FetchSearchOrgan(organ: textValue));
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  textValue == null
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.organsModel.length,
                            itemBuilder: (BuildContext context, index) {
                              final organs = state.organsModel[index];

                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AdultUnwellMenuItems(
                                    text: organs.name,
                                    press: () async {
                                      BlocProvider.of<OrgansDetailsBloc>(context).add(FetchOrganDetails(id: organs.id));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OrganDetailsScreen(
                                            title: organs.name,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : BlocBuilder<SearchOrganBloc, SearchOrganState>(
                          builder: (context, state) {
                            if (state is SearchOrganLoading) {
                              return Center(
                                child: Container(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                ),
                              );
                            }
                            if (state is SearchOrganLoaded) {
                              return Expanded(
                                child: state.searchOrgan.length > 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.searchOrgan.length,
                                        itemBuilder: (BuildContext context, index) {
                                          final search = state.searchOrgan[index];

                                          return Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: AdultUnwellMenuItems(
                                                text: search.name,
                                                press: () async {
                                                  BlocProvider.of<ConditionDetailsBloc>(context).add(FetchDetails(id: search.id));
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ConditionDetailsScreen(
                                                        title: search.name,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Sorry,$textValue did not match any condition in our Database, please refine your search or",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => DoctorConsult(),
                                                        ),
                                                      );
                                                    },
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        " Consult a doctor",
                                                        style: TextStyle(color: Colors.lightBlueAccent),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => FacilitiesCategoriesScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        " or a facility for further help",
                                                        style: TextStyle(
                                                          color: Colors.lightBlueAccent,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
