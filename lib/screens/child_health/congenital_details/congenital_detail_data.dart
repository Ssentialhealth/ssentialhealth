import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pocket_health/bloc/child_health/congenital_detail/congenital_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/congenital_detail/congenital_detail_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/widgets/widget.dart';


class CongenitalDetailsData extends StatelessWidget {
  const CongenitalDetailsData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CongenitalConditionDetailsBloc,CongenitalConditionDetailsState>
      (builder: (BuildContext context,state){
        if(state is CongenitalConditionDetailsInitial){
          return Container(color: Colors.black,height: 300,);
        }
        if(state is CongenitalConditionDetailsLoaded){
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
                      data: state.congenitalDetailModel.overview
                  ),
                  SizedBox(height: 12,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Causes",
                        style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.congenitalDetailModel.mainCauses.length,
                      itemBuilder: (BuildContext context,index){
                        final mainCauses = state.congenitalDetailModel.mainCauses[index];
                        return Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child:Markdown(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  styleSheet: MarkdownStyleSheet(
                                      h2: simpleTextStyle()
                                  ),
                                  data: "• "+mainCauses
                              ),


                            )
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Sign and Symptoms",
                        style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.congenitalDetailModel.signsAndSymptoms.length,
                      itemBuilder: (BuildContext context,index){
                        final signsAndSymptoms = state.congenitalDetailModel.signsAndSymptoms[index];
                        return Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child:Markdown(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  styleSheet: MarkdownStyleSheet(
                                      h2: simpleTextStyle()
                                  ),
                                  data: "• "+signsAndSymptoms
                              ),


                            )
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h,),





                ],
              ),
            ),
          );
        }
        if(state is CongenitalConditionDetailsError){
          return Container(color: Colors.blueGrey,height: 40,);
        }
        return Container(
            height: 50,
            child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));

    });
  }
}
