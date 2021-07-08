import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/congenital_condition/congenital_condition_bloc.dart';
import 'package:pocket_health/bloc/child_health/congenital_condition/congenital_condition_state.dart';
import 'package:pocket_health/bloc/child_health/congenital_detail/congenital_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/congenital_detail/congenital_detail_event.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_bloc.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_event.dart';
import 'package:pocket_health/screens/child_health/congenital_details/congenital_detail_screen.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/widgets/widget.dart';


class CongenitalData extends StatefulWidget {
  const CongenitalData({Key key}) : super(key: key);

  @override
  _CongenitalDataState createState() => _CongenitalDataState();
}

class _CongenitalDataState extends State<CongenitalData> {
  String textValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CongenitalConditionBloc,CongenitalConditionState>(
        builder: (BuildContext context,state){
            if(state is CongenitalConditionInitial){
              return Container(color: Colors.black,height: 300,);
            }
            if(state is CongenitalConditionLoaded){
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

                    ],
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.congenitalConditionModel.length,
                      itemBuilder: (BuildContext context,index){
                        final congenital = state.congenitalConditionModel[index];
                        return Container(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8),
                              child: AdultUnwellMenuItems(text: congenital.name,
                                press: ()async{
                                  BlocProvider.of<CongenitalConditionDetailsBloc>(context).add(FetchCongenitalConditionDetails(id: congenital.id));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CongenitalDetailScreen(title: congenital.name,)));

                                },
                              )
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            if(state is CongenitalConditionError){
              return Container(color: Colors.blueGrey,height: 40,);
            }
            return Container(
                height: 50,
                child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
        }
    );
  }
}
