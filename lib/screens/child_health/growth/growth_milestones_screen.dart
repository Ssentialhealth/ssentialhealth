import 'package:flutter/material.dart';
import 'package:pocket_health/screens/child_health/normal_development/normal_development_screen.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';

class GrowthAndMilestones extends StatefulWidget {
  const GrowthAndMilestones({Key key}) : super(key: key);

  @override
  _GrowthAndMilestonesState createState() => _GrowthAndMilestonesState();
}

class _GrowthAndMilestonesState extends State<GrowthAndMilestones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Growth & Milestones",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:15,horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdultUnwellMenuItems(text: "Normal Development Milestones",press: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NormalDevelopmentScreen()));
                },),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdultUnwellMenuItems(text: "Growth Tables & Charts",),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdultUnwellMenuItems(text: "Delayed Milestones or Abnormal Growth & Development",),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
