import 'package:flutter/material.dart';
import 'package:pocket_health/screens/child_health/all_schedules/all_schdules_data.dart';
import 'package:pocket_health/screens/child_health/immunization_schedule/immunization_schedule_screen.dart';

class AllSchedules extends StatefulWidget {
  const AllSchedules({Key key}) : super(key: key);

  @override
  _AllSchedulesState createState() => _AllSchedulesState();
}

class _AllSchedulesState extends State<AllSchedules> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Immunization Schedules",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff163C4D),
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ImmunizationChartScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Generated Schedule Chart for:",
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                  ),

                ],
              ),
            ),
            AllSchedulesData()

          ],
        ),
      ),
    );
  }
}
