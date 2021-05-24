import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pocket_health/bloc/child_health/normal_development/normal_development_bloc.dart';
import 'package:pocket_health/bloc/child_health/normal_development/normal_development_state.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NormalDevelopmentData extends StatelessWidget {
  const NormalDevelopmentData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NormalDevelopmentBloc,NormalDevelopmentState>(
        builder: (context,state){
          if(state is NormalDevelopmentInitial){
            return Container(color: Colors.black,height: 300,);
          }
          if(state is NormalDevelopmentLoaded){

            return Container(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: Markdown(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        styleSheet: MarkdownStyleSheet(
                            h2: simpleTextStyle()
                        ),
                        data: state.normalDevelopmentModel.overview.overview
                    ),
                  ),
                  SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Simplified Growth and Development Milestones Chart",
                          style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    // child: Padding(
                    //   padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 8.0),
                    //   child: Card(
                    //     color: Colors.white,
                    //     child: ListView.builder(
                    //       shrinkWrap: true,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       itemCount: state.normalDevelopmentModel.milestones.length,
                    //       itemBuilder: (BuildContext context,index){
                    //         final normalDevelopment = state.normalDevelopmentModel.milestones[index];
                    //         return Column(
                    //           children: [
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5.0),
                    //               child: Align(
                    //                   alignment: Alignment.topLeft,
                    //                   child: Text(normalDevelopment.age)
                    //               ),
                    //             ),
                    //             Divider(color: Color(0xFFC6C6C6),indent: 5,endIndent: 5,),
                    //             Container(
                    //               constraints: BoxConstraints(minHeight: 10.h),
                    //               child: ListView.builder(
                    //                   shrinkWrap: true,
                    //                   physics: NeverScrollableScrollPhysics(),
                    //                   itemCount: normalDevelopment.expectedMilestones.length,
                    //                   itemBuilder: (BuildContext context,index){
                    //                     final expectedMilestone = normalDevelopment.expectedMilestones[index];
                    //                     return Container(
                    //                         child: Padding(
                    //                             padding: const EdgeInsets.all(8.0),
                    //                             child: Text("•"+expectedMilestone)
                    //
                    //                         )
                    //                     );
                    //                   }
                    //               ),
                    //             )
                    //
                    //           ],
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.normalDevelopmentModel.milestones.length,
                        itemBuilder: (BuildContext context,index){
                          final expectedMilestone = state.normalDevelopmentModel.milestones[index];
                          return Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5.0),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(expectedMilestone.age)
                                            ),
                                          ),
                                          Divider(color: Color(0xFFC6C6C6),indent: 5,endIndent: 5,),
                                          Container(
                                            constraints: BoxConstraints(minHeight: 10.h),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: expectedMilestone.expectedMilestones.length,
                                                itemBuilder: (BuildContext context,index){
                                                  final expectedMilestoneList = expectedMilestone.expectedMilestones[index];
                                                  return Container(
                                                      child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text("•"+expectedMilestoneList)

                                                      )
                                                  );
                                                }
                                            ),
                                          )

                                        ],
                                      )
                                  ),

                              )
                          );
                        }
                    ),
                  )
                ],
              ),
            );
          }
          if(state is NormalDevelopmentError){
            return Container(color: Colors.blueGrey,height: 40,);
          }
          return Container(
              height: 50,
              child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
        }
    );

  }
}
