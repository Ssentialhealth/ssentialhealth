import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_bloc.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_event.dart';
import 'package:pocket_health/screens/child_health/generate_immunization_schedule/generate_immunization_schedule_screen.dart';

import 'all_immunization_schedules_data.dart';

class AllImmunizationSchedulesScreen extends StatefulWidget {
  const AllImmunizationSchedulesScreen({Key key}) : super(key: key);

  @override
  _AllImmunizationSchedulesScreenState createState() => _AllImmunizationSchedulesScreenState();
}

class _AllImmunizationSchedulesScreenState extends State<AllImmunizationSchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text(
          "All Immunization Schedules",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff163C4D),
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            BlocProvider.of<ImmunizationScheduleBloc>(context).add(LoadInitial());

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return GenerateImmunizationScheduleScreen();
                },
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
	            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Generated Schedule Chart for:",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
	          AllImmunizationSchedulesData()
          ],
        ),
      ),
    );
  }
}
