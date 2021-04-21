import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailState.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsBloc.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class DetailsData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConditionDetailsBloc,ConditionDetailsState>(
        builder: (context,state){
          if(state is ConditionDetailsInitial){
            return Container(color: Colors.black,height: 300,);
          }
          if(state is ConditionDetailsLoaded){
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
                    SizedBox(height: 12,),
                    Text(state.conditionDetails.overview,
                        style:simpleTextStyle()
                    ),
                    SizedBox(height: 12,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Common Management",
                          style:TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold

                          )),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      constraints: BoxConstraints(minHeight: 10.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.conditionDetails.commonManagement.length,
                        itemBuilder: (BuildContext context,index){
                        final accident = state.conditionDetails.commonManagement[index];
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(accident)

                            )
                        );
                    },
                  ),
                ),
                    SizedBox(height: 12,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Possible Causing Conditions",
                          style:TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      constraints: BoxConstraints(minHeight: 10.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.conditionDetails.possibleCausingConditions.length,
                        itemBuilder: (BuildContext context,index){
                          final accident = state.conditionDetails.possibleCausingConditions[index];
                          return Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("• "+accident)

                              )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
            print(state.conditionDetails.name);
          }
          if(state is ConditionDetailsError){
            return Container(color: Colors.blueGrey,height: 40,);
          }else{
            return Container(
                height: 50,
                child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
          }
        });

  }
}
