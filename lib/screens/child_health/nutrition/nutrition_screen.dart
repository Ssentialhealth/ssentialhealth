import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pocket_health/bloc/child_health/nutrition_bloc/nutrition_bloc.dart';
import 'package:pocket_health/bloc/child_health/nutrition_bloc/nutrition_state.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Child Nutrition",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: BlocBuilder<NutritionBloc,NutritionState>(
          builder: (context,state){
            if(state is NutritionLoaded){
              return Column(
                children: [
                  Container(
                    child: DefaultTabController(
                      length: 2,
                      child: Container(
                        constraints: BoxConstraints(minHeight: 10.h),
                        child: SizedBox(
                          height:445,
                          child: Column(
                            children: <Widget>[
                              ButtonsTabBar(
                                backgroundColor: Colors.lightBlueAccent,
                                tabs:
                                [
                                  Tab(
                                    text: "0-6 Months"
                                  ),
                                  Tab(
                                    text: "6-12 Months",
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints(minHeight: 10.h),
                                  child: TabBarView(
                                    children: [
                                      Center(
                                        child:Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state.nutritionModel.length,
                                            itemBuilder: (BuildContext context,index){
                                              final nutritionA = state.nutritionModel[index];
                                              final data = nutritionA.the06Months[index];
                                              return Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                                                    child:Markdown(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        styleSheet: MarkdownStyleSheet(
                                                            h2: simpleTextStyle()
                                                        ),
                                                        data: "• "+data
                                                    ),


                                                  )
                                              );
                                            },
                                          ),
                                        ),

                                      ),
                                      Center(
                                        child:Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state.nutritionModel.length,
                                            itemBuilder: (BuildContext context,index){
                                              final nutritionA = state.nutritionModel[index];
                                              final dataB = nutritionA.the06Months[index];                                          return Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                                                    child:Container(
                                                      constraints: BoxConstraints(minHeight: 10.h),
                                                      child: Markdown(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          styleSheet: MarkdownStyleSheet(
                                                              h2: simpleTextStyle()
                                                          ),
                                                          data: "• "+dataB
                                                      ),
                                                    ),


                                                  )
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              );
            }
            return Center(
              child: Container(
                  child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)
              ),
            );
          }
        )
      )
    );
  }
}
