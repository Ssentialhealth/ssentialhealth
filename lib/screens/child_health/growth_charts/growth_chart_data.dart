import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pocket_health/bloc/child_health/growth_charts/growth_chart_bloc.dart';
import 'package:pocket_health/bloc/child_health/growth_charts/growth_chart_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/widgets/widget.dart';


class GrowthChartData extends StatelessWidget {
  const GrowthChartData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GrowthChartBloc,GrowthChartState>(
        builder: (context,state){
          if(state is GrowthChartInitial){
            return Container(color: Colors.black,height: 300,);
          }
          if(state is GrowthChartLoaded){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.growthChatModel.data.length,
                  itemBuilder: (BuildContext context,index){
                    final growthChart = state.growthChatModel.data[index];
                    return Container(
                        child: Column(
                          children: [
                            Markdown(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                styleSheet: MarkdownStyleSheet(
                                    h2: simpleTextStyle()
                                ),
                                data: state.growthChatModel.overview.overview
                            ),
                            Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5.0),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(growthChart.name)
                                      ),
                                    ),
                                    Divider(color: Color(0xFFC6C6C6),indent: 5,endIndent: 5,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5.0),
                                      child:  Container(
                                        constraints: BoxConstraints(minHeight: 10.h),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: growthChart.links.length,
                                            itemBuilder: (BuildContext context,index){
                                              final linksList = growthChart.links[index] ;
                                              return  Column(
                                                children: [
                                                  Align(
                                                      alignment: Alignment.center,
                                                      child: Image.network(linksList)
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text("Link to Source")
                                                  ),
                                                  Markdown(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      styleSheet: MarkdownStyleSheet(
                                                          h2: simpleTextStyle()
                                                      ),
                                                      data: linksList
                                                  ),
                                                ],
                                              );
                                            }
                                        ),
                                      )
                                    ),


                                  ],
                                )
                            ),
                          ],
                        )
                    );
                  }
              ),
            );
          }
          if(state is GrowthChartError){
            return Container(color: Colors.blueGrey,height: 40,);
          }
          return Container(
              height: 50,
              child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
        }
    );
  }
}
