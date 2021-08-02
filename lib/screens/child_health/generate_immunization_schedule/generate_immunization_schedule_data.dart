import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_bloc.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_state.dart';
import 'package:pocket_health/widgets/widget.dart';

class GenerateImmunizationScheduleData extends StatefulWidget {
  const GenerateImmunizationScheduleData({Key key}) : super(key: key);

  @override
  _GenerateImmunizationScheduleDataState createState() => _GenerateImmunizationScheduleDataState();
}

class _GenerateImmunizationScheduleDataState extends State<GenerateImmunizationScheduleData> {
  String dateOfBirth;
  String atBirthReceived;
  String atBirthDate;
  String week6Receieved;
  String week6Date;
  String week10Receieved;
  String week10Date;
  String week14Receieved;
  String week14Date;
  String month6Receieved;
  String month6Date;
  String month7Receieved;
  String month7Date;

  TextEditingController dob = new TextEditingController();
  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('en_US');
    Intl.defaultLocale = 'en';
    return BlocBuilder<ImmunizationScheduleBloc, ImmunizationScheduleState>(
      builder: (BuildContext context, state) {
        if (state is ImmunizationScheduleInitial) {
          return Container();
        }
        if (state is ImmunizationScheduleLoaded) {
          return Column(
            children: [
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 10.h),
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, index) {
                          //at birth
                          final atBirth = state.immunizationScheduleModel.schedules.where((element) => element.age == 'At birth').toList()[0];
                          final week6 = state.immunizationScheduleModel.schedules.where((element) => element.age == '6 Weeks').toList()[0];
                          final week10 = state.immunizationScheduleModel.schedules.where((element) => element.age == '10 weeks').toList()[0];
                          final week14 = state.immunizationScheduleModel.schedules.where((element) => element.age == '14 weeks').toList()[0];
                          final month6 = state.immunizationScheduleModel.schedules.where((element) => element.age == '6 months').toList()[0];
                          final month7 = state.immunizationScheduleModel.schedules.where((element) => element.age == '7 months').toList()[0];

                          final week6Vaccines = week6.vaccines;
                          final atBirthVaccines = atBirth.vaccines;
                          final week10Vaccines = week10.vaccines;
                          final week14Vaccines = week14.vaccines;
                          final month6Vaccines = month6.vaccines;
                          final month7Vaccines = month7.vaccines;

                          final immunization = state.immunizationScheduleModel.schedules[index];
                          var preDate = immunization.dueDate.toString();
                          var dates = DateTime.parse(preDate);
                          var formattedDate = "${dates.day}-${dates.month}-${dates.year}";
                          final vaccine = immunization.vaccines[index];

                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                              child: Column(
                                children: [
                                  ...List.generate(
                                    atBirthVaccines.length,
                                    (idx) => Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00FFFF),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.centerLeft, child: Text('At birth')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Container(constraints: BoxConstraints(minHeight: 10.h), child: Text(atBirthVaccines[idx].vaccineName)),
                                              Divider(color: Color(0xff163C4D)),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Due Date: ")),
                                                      ),
                                                      Expanded(
	                                                      child: Align(alignment: Alignment.centerLeft, child: Text(atBirth.dueDate.toString())),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Date Received:")),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          atBirthDate ?? '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.date_range)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(color: Color(0xff163C4D)),
                                              DropdownButtonFormField(
                                                decoration: inputDeco(""),
                                                hint: Text("Not Received"),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(color: Colors.deepOrange),
                                                items: ['Received', 'Not Received'].map((val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...List.generate(
                                    week6Vaccines.length,
                                    (idx) => Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00FFFF),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.centerLeft, child: Text('6 weeks')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Container(constraints: BoxConstraints(minHeight: 10.h), child: Text(week6Vaccines[idx].vaccineName)),
                                              Divider(color: Color(0xff163C4D)),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Due Date: ")),
                                                      ),
                                                      Expanded(
	                                                      child: Align(alignment: Alignment.centerLeft, child: Text(week6.dueDate.toString())),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Date Received:")),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          week6Date ?? '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.date_range)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(color: Color(0xff163C4D)),
                                              DropdownButtonFormField(
                                                decoration: inputDeco(""),
                                                hint: Text("Not Received"),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(color: Colors.deepOrange),
                                                items: ['Received', 'Not Received'].map((val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...List.generate(
                                    week10Vaccines.length,
                                    (idx) => Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00FFFF),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.centerLeft, child: Text('10 Weeks')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Container(constraints: BoxConstraints(minHeight: 10.h), child: Text(week10Vaccines[idx].vaccineName)),
                                              Divider(color: Color(0xff163C4D)),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Due Date: ")),
                                                      ),
                                                      Expanded(
	                                                      child: Align(alignment: Alignment.centerLeft, child: Text(week10.dueDate.toString())),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Date Received:")),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          week10Date ?? '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.date_range)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(color: Color(0xff163C4D)),
                                              DropdownButtonFormField(
                                                decoration: inputDeco(""),
                                                hint: Text("Not Received"),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(color: Colors.deepOrange),
                                                items: ['Received', 'Not Received'].map((val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...List.generate(
                                    week14Vaccines.length,
                                    (idx) => Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00FFFF),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.centerLeft, child: Text('14 Weeks')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Container(constraints: BoxConstraints(minHeight: 10.h), child: Text(week14Vaccines[idx].vaccineName)),
                                              Divider(color: Color(0xff163C4D)),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Due Date: ")),
                                                      ),
                                                      Expanded(
	                                                      child: Align(alignment: Alignment.centerLeft, child: Text(week14.dueDate.toString())),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Date Received:")),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          week14Date ?? '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.date_range)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(color: Color(0xff163C4D)),
                                              DropdownButtonFormField(
                                                decoration: inputDeco(""),
                                                hint: Text("Not Received"),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(color: Colors.deepOrange),
                                                items: ['Received', 'Not Received'].map((val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...List.generate(
                                    month6Vaccines.length,
                                    (idx) => Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00FFFF),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.centerLeft, child: Text('6 Months')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Container(constraints: BoxConstraints(minHeight: 10.h), child: Text(month6Vaccines[idx].vaccineName)),
                                              Divider(color: Color(0xff163C4D)),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Due Date: ")),
                                                      ),
                                                      Expanded(
	                                                      child: Align(alignment: Alignment.centerLeft, child: Text(month6.dueDate.toString())),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Date Received:")),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          month6Date ?? '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.date_range)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(color: Color(0xff163C4D)),
                                              DropdownButtonFormField(
                                                decoration: inputDeco(""),
                                                hint: Text("Not Received"),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(color: Colors.deepOrange),
                                                items: ['Received', 'Not Received'].map((val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...List.generate(
                                    month7Vaccines.length,
                                    (idx) => Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minHeight: 10.h),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00FFFF),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.centerLeft, child: Text('7 Months')),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Container(constraints: BoxConstraints(minHeight: 10.h), child: Text(month7Vaccines[idx].vaccineName)),
                                              Divider(color: Color(0xff163C4D)),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Due Date: ")),
                                                      ),
                                                      Expanded(
	                                                      child: Align(alignment: Alignment.centerLeft, child: Text(month7.dueDate.toString())),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(alignment: Alignment.centerLeft, child: Text("Date Received:")),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          month7Date ?? '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.date_range)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(color: Color(0xff163C4D)),
                                              DropdownButtonFormField(
                                                decoration: inputDeco(""),
                                                hint: Text("Not Received"),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(color: Colors.deepOrange),
                                                items: ['Received', 'Not Received'].map((val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ],
          );
        }
        if (state is ImmunizationScheduleError) {
          return Container(
            color: Colors.blueGrey,
            height: 40,
          );
        }
        return Container(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          ),
        );
      },
    );
  }
}
