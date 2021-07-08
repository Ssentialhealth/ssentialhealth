import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellEvent.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsBloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsEvent.dart';
import 'package:pocket_health/bloc/symptoms/details/symptoms_bloc.dart';
import 'package:pocket_health/bloc/symptoms/details/symptoms_event.dart';
import 'package:pocket_health/bloc/symptoms/details/symptoms_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/AdultUnwell/condition_details/conditionDetailsScreen.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';


class SymptomData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymptomDetailsBloc,SymptomDetailsState>(
      builder: (context,state){
        if(state is SymptomDetailsLoading){
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,));
        }
        if(state is SymptomDetailsLoaded){
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Overview",
                        style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(height: 8.h,),
                  Markdown(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      styleSheet: MarkdownStyleSheet(
                          h2: simpleTextStyle()
                      ),
                      data: state.symptomDetail.overview
                  ),
                  SizedBox(height: 8.h,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Common Management",
                        style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(height: 8.h,),
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.symptomDetail.commonManagement.length,
                      itemBuilder: (BuildContext context,index){
                        final accident = state.symptomDetail.commonManagement[index];
                        return Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("• "+accident)

                            )
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Possible Conditions",
                        style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(height: 8.h,),
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.symptomDetail.healthConditions.length,
                      itemBuilder: (BuildContext context,index){
                        final accident = state.symptomDetail.healthConditions[index];
                        return Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AdultUnwellMenuItems(text: accident.name,
                                  press: ()async{
                                    BlocProvider.of<ConditionDetailsBloc>(context).add(FetchDetails(id: accident.id));
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConditionDetailsScreen(title: accident.name,)));

                                  },
                                )

                            )
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
            height: 50,
            child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
      },
    );
  }
}
