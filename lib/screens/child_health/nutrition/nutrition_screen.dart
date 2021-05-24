import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/nutrition_bloc/nutrition_bloc.dart';
import 'package:pocket_health/bloc/child_health/nutrition_bloc/nutrition_state.dart';

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
              final nutrition = state.nutritionModel[0];
              return Column(
                children: [
                  Container(
                    child: DefaultTabController(
                      length: state.nutritionModel.length,
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: <Widget>[
                            ButtonsTabBar(
                              backgroundColor: Colors.lightBlueAccent,
                              tabs:
                              [
                                Tab(
                                  text: nutrition.phase,
                                ),
                                Tab(
                                  text: nutrition.phase,
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Center(
                                    child: Text(nutrition.phase),
                                  ),
                                  Center(
                                    child: Icon(Icons.directions_car),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
