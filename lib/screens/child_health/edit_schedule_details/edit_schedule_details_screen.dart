import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_bloc.dart';
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_event.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_state.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:pocket_health/widgets/widget.dart';

class EditScheduleDetailsScreen extends StatefulWidget {
  final id;

  const EditScheduleDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _EditScheduleDetailsScreenState createState() => _EditScheduleDetailsScreenState();
}

class _EditScheduleDetailsScreenState extends State<EditScheduleDetailsScreen> {
	String dateOfBirth;
  String received;
  final ApiService apiService = ApiService(http.Client());

  final httpClient = http.Client();

  Map<String, bool> atBirthReceivedVals = {
    '0-receivedVal': false,
    '1-receivedVal': false,
    '2-receivedVal': false,
    '3-receivedVal': false,
  };
  Map<String, bool> atBirthReceivedChecks = {
    '0-hasReceivedChanged': false,
    '1-hasReceivedChanged': false,
    '2-hasReceivedChanged': false,
    '3-hasReceivedChanged': false,
  };
  Map<String, String> atBirthDates = {
    '0-dateReceived': null,
    '1-dateReceived': null,
    '2-dateReceived': null,
    '3-dateReceived': null,
  };
  Map<String, bool> week6ReceivedVals = {
    '0-receivedVal': false,
    '1-receivedVal': false,
    '2-receivedVal': false,
    '3-receivedVal': false,
  };
  Map<String, bool> week6ReceivedChecks = {
    '0-hasReceivedChanged': false,
    '1-hasReceivedChanged': false,
    '2-hasReceivedChanged': false,
    '3-hasReceivedChanged': false,
  };
  Map<String, String> week6Dates = {
    '0-dateReceived': null,
    '1-dateReceived': null,
    '2-dateReceived': null,
    '3-dateReceived': null,
  };

  Map<String, bool> week10ReceivedVals = {
    '0-receivedVal': false,
    '1-receivedVal': false,
    '2-receivedVal': false,
    '3-receivedVal': false,
  };
  Map<String, bool> week10ReceivedChecks = {
    '0-hasReceivedChanged': false,
    '1-hasReceivedChanged': false,
    '2-hasReceivedChanged': false,
    '3-hasReceivedChanged': false,
  };
  Map<String, String> week10Dates = {
    '0-dateReceived': null,
    '1-dateReceived': null,
    '2-dateReceived': null,
    '3-dateReceived': null,
  };
  Map<String, bool> week14ReceivedVals = {
    '0-receivedVal': false,
    '1-receivedVal': false,
    '2-receivedVal': false,
    '3-receivedVal': false,
  };
  Map<String, bool> week14ReceivedChecks = {
    '0-hasReceivedChanged': false,
    '1-hasReceivedChanged': false,
    '2-hasReceivedChanged': false,
    '3-hasReceivedChanged': false,
  };
  Map<String, String> week14Dates = {
    '0-dateReceived': null,
    '1-dateReceived': null,
    '2-dateReceived': null,
    '3-dateReceived': null,
  };
  Map<String, bool> month6ReceivedVals = {
    '0-receivedVal': false,
    '1-receivedVal': false,
    '2-receivedVal': false,
    '3-receivedVal': false,
  };
  Map<String, bool> month6ReceivedChecks = {
    '0-hasReceivedChanged': false,
    '1-hasReceivedChanged': false,
    '2-hasReceivedChanged': false,
    '3-hasReceivedChanged': false,
  };
  Map<String, String> month6Dates = {
    '0-dateReceived': null,
    '1-dateReceived': null,
    '2-dateReceived': null,
    '3-dateReceived': null,
  };
  Map<String, bool> month7ReceivedVals = {
    '0-receivedVal': false,
  };
  Map<String, bool> month7ReceivedChecks = {
    '0-hasReceivedChanged': false,
  };
  Map<String, String> month7Dates = {
    '0-dateReceived': null,
  };

  TextEditingController dob = new TextEditingController();
  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text(
          "Edit Your Schedule Details",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () async {
	          context.read<AllSchedulesBloc>()..add(FetchAllSchedules());
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ScheduleDetailsBloc, ScheduleDetailsState>(builder: (BuildContext context, state) {
          if (state is ScheduleDetailsInitial) {
            return Container(
              color: Colors.green,
              height: 40,
            );
          }
          if (state is ScheduleDetailsLoaded) {
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
                            final atBirth = state.scheduleDetails.schedules.where((element) => element.age == 'At birth').toList()[0];
                            final week6 = state.scheduleDetails.schedules.where((element) => element.age == '6 Weeks').toList()[0];
                            final week10 = state.scheduleDetails.schedules.where((element) => element.age == '10 weeks').toList()[0];
                            final week14 = state.scheduleDetails.schedules.where((element) => element.age == '14 weeks').toList()[0];
                            final month6 = state.scheduleDetails.schedules.where((element) => element.age == '6 months').toList()[0];
                            final month7 = state.scheduleDetails.schedules.where((element) => element.age == '7 months').toList()[0];

                            final week6Vaccines = week6.vaccines;
                            final atBirthVaccines = atBirth.vaccines;
                            final week10Vaccines = week10.vaccines;
                            final week14Vaccines = week14.vaccines;
                            final month6Vaccines = month6.vaccines;
                            final month7Vaccines = month7.vaccines;

                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                child: Column(
                                  children: [
                                    //at birth
                                    ...List.generate(
                                      atBirthVaccines.length,
                                      (idx) {
                                        final vaccine = atBirthVaccines[idx];
                                        return Column(
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
                                                              atBirthDates['$idx-dateReceived'] == null
                                                                  ? atBirthVaccines[idx].dateReceived == null
                                                                      ? ""
                                                                      : atBirthVaccines[idx].dateReceived
                                                                  : atBirthDates['$idx-dateReceived'],
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(Icons.date_range),
                                                            onTap: () {
                                                              DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions: true,
                                                                currentTime: DateTime.now(),
                                                                locale: LocaleType.en,
                                                                minTime: DateTime(1963, 3, 5),
                                                                maxTime: DateTime.now(),
                                                                onChanged: (date) {},
                                                                onConfirm: (date) async {
                                                                  setState(() {
                                                                    atBirthDates['$idx-dateReceived'] = date.toString().split(' ').first;
                                                                  });
                                                                  await apiService.updateReceived(
                                                                    vaccine: vaccine,
                                                                    hasReceivedChanged: atBirthReceivedChecks['$idx-hasReceivedChanged'],
                                                                    initialReceivedDate: atBirthVaccines[idx].dateReceived,
                                                                    newReceivedDate: atBirthDates['$idx-dateReceived'],
                                                                    initialReceivedVal: atBirthVaccines[idx].received,
                                                                    newReceivedVal: atBirthReceivedVals["$idx-receivedVal"],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(color: Color(0xff163C4D)),
                                                  DropdownButtonFormField(
                                                    decoration: inputDeco(atBirthVaccines[idx].received ? "Received" : "Not Received"),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: Colors.deepOrange),
                                                    items: [
                                                      'Received',
                                                      'Not Received',
                                                    ].map(
                                                      (val) {
                                                        return DropdownMenuItem<String>(
                                                          value: val,
                                                          child: Text(val),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) async {
                                                      setState(() {
                                                        atBirthReceivedChecks['$idx-hasReceivedChanged'] = true;
                                                        val == "Received"
                                                            ? atBirthReceivedVals["$idx-receivedVal"] = true
                                                            : atBirthReceivedVals["$idx-receivedVal"] = false;
                                                      });

                                                      await apiService.updateReceived(
                                                        vaccine: vaccine,
                                                        hasReceivedChanged: atBirthReceivedChecks['$idx-hasReceivedChanged'],
                                                        newReceivedDate: atBirthDates['$idx-dateReceived'],
                                                        initialReceivedDate: atBirthVaccines[idx].dateReceived,
                                                        newReceivedVal: atBirthReceivedVals["$idx-receivedVal"],
                                                        initialReceivedVal: atBirthVaccines[idx].received,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    //week 6
                                    ...List.generate(
                                      week6Vaccines.length,
                                      (idx) {
                                        final vaccine = week6Vaccines[idx];
                                        return Column(
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(minHeight: 10.h),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF00FFFF),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(alignment: Alignment.centerLeft, child: Text('6 Weeks')),
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
                                                              week6Dates['$idx-dateReceived'] == null
                                                                  ? week6Vaccines[idx].dateReceived == null
                                                                      ? ""
                                                                      : week6Vaccines[idx].dateReceived
                                                                  : week6Dates['$idx-dateReceived'],
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(Icons.date_range),
                                                            onTap: () {
                                                              DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions: true,
                                                                currentTime: DateTime.now(),
                                                                locale: LocaleType.en,
                                                                minTime: DateTime(1963, 3, 5),
                                                                maxTime: DateTime.now(),
                                                                onChanged: (date) {},
                                                                onConfirm: (date) async {
                                                                  setState(() {
                                                                    week6Dates['$idx-dateReceived'] = date.toString().split(' ').first;
                                                                  });
                                                                  await apiService.updateReceived(
                                                                    vaccine: vaccine,
                                                                    hasReceivedChanged: week6ReceivedChecks['$idx-hasReceivedChanged'],
                                                                    initialReceivedDate: week6Vaccines[idx].dateReceived,
                                                                    newReceivedDate: week6Dates['$idx-dateReceived'],
                                                                    initialReceivedVal: week6Vaccines[idx].received,
                                                                    newReceivedVal: week6ReceivedVals["$idx-receivedVal"],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(color: Color(0xff163C4D)),
                                                  DropdownButtonFormField(
                                                    decoration: inputDeco(week6Vaccines[idx].received ? "Received" : "Not Received"),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: Colors.deepOrange),
                                                    items: [
                                                      'Received',
                                                      'Not Received',
                                                    ].map(
                                                      (val) {
                                                        return DropdownMenuItem<String>(
                                                          value: val,
                                                          child: Text(val),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) async {
                                                      setState(() {
                                                        week6ReceivedChecks['$idx-hasReceivedChanged'] = true;
                                                        val == "Received"
                                                            ? week6ReceivedVals["$idx-receivedVal"] = true
                                                            : week6ReceivedVals["$idx-receivedVal"] = false;
                                                      });

                                                      await apiService.updateReceived(
                                                        vaccine: vaccine,
                                                        hasReceivedChanged: week6ReceivedChecks['$idx-hasReceivedChanged'],
                                                        newReceivedDate: week6Dates['$idx-dateReceived'],
                                                        initialReceivedDate: week6Vaccines[idx].dateReceived,
                                                        newReceivedVal: week6ReceivedVals["$idx-receivedVal"],
                                                        initialReceivedVal: week6Vaccines[idx].received,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    //week 10
                                    ...List.generate(
                                      week10Vaccines.length,
                                      (idx) {
                                        final vaccine = week10Vaccines[idx];
                                        return Column(
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
                                                  Container(
                                                    constraints: BoxConstraints(minHeight: 10.h),
                                                    child: Text(week10Vaccines[idx].vaccineName),
                                                  ),
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
                                                              week10Dates['$idx-dateReceived'] == null
                                                                  ? week10Vaccines[idx].dateReceived == null
                                                                      ? ""
                                                                      : week10Vaccines[idx].dateReceived
                                                                  : week10Dates['$idx-dateReceived'],
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(Icons.date_range),
                                                            onTap: () {
                                                              DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions: true,
                                                                currentTime: DateTime.now(),
                                                                locale: LocaleType.en,
                                                                minTime: DateTime(1963, 3, 5),
                                                                maxTime: DateTime.now(),
                                                                onChanged: (date) {},
                                                                onConfirm: (date) async {
                                                                  setState(() {
                                                                    week10Dates['$idx-dateReceived'] = date.toString().split(' ').first;
                                                                  });
                                                                  await apiService.updateReceived(
                                                                    vaccine: vaccine,
                                                                    hasReceivedChanged: week10ReceivedChecks['$idx-hasReceivedChanged'],
                                                                    initialReceivedDate: week10Vaccines[idx].dateReceived,
                                                                    newReceivedDate: week10Dates['$idx-dateReceived'],
                                                                    initialReceivedVal: week10Vaccines[idx].received,
                                                                    newReceivedVal: week10ReceivedVals["$idx-receivedVal"],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(color: Color(0xff163C4D)),
                                                  DropdownButtonFormField(
                                                    decoration: inputDeco(week10Vaccines[idx].received ? "Received" : "Not Received"),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: Colors.deepOrange),
                                                    items: [
                                                      'Received',
                                                      'Not Received',
                                                    ].map(
                                                      (val) {
                                                        return DropdownMenuItem<String>(
                                                          value: val,
                                                          child: Text(val),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) async {
                                                      setState(() {
                                                        week10ReceivedChecks['$idx-hasReceivedChanged'] = true;
                                                        val == "Received"
                                                            ? week10ReceivedVals["$idx-receivedVal"] = true
                                                            : week10ReceivedVals["$idx-receivedVal"] = false;
                                                      });

                                                      await apiService.updateReceived(
                                                        vaccine: vaccine,
                                                        hasReceivedChanged: week10ReceivedChecks['$idx-hasReceivedChanged'],
                                                        newReceivedDate: week10Dates['$idx-dateReceived'],
                                                        initialReceivedDate: week10Vaccines[idx].dateReceived,
                                                        newReceivedVal: week10ReceivedVals["$idx-receivedVal"],
                                                        initialReceivedVal: week10Vaccines[idx].received,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    //week 14
                                    ...List.generate(
                                      week14Vaccines.length,
                                      (idx) {
                                        final vaccine = week14Vaccines[idx];
                                        return Column(
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
                                                              week14Dates['$idx-dateReceived'] == null
                                                                  ? week14Vaccines[idx].dateReceived == null
                                                                      ? ""
                                                                      : week14Vaccines[idx].dateReceived
                                                                  : week14Dates['$idx-dateReceived'],
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(Icons.date_range),
                                                            onTap: () {
                                                              DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions: true,
                                                                currentTime: DateTime.now(),
                                                                locale: LocaleType.en,
                                                                minTime: DateTime(1963, 3, 5),
                                                                maxTime: DateTime.now(),
                                                                onChanged: (date) {},
                                                                onConfirm: (date) async {
                                                                  setState(() {
                                                                    week14Dates['$idx-dateReceived'] = date.toString().split(' ').first;
                                                                  });
                                                                  await apiService.updateReceived(
                                                                    vaccine: vaccine,
                                                                    hasReceivedChanged: week14ReceivedChecks['$idx-hasReceivedChanged'],
                                                                    initialReceivedDate: week14Vaccines[idx].dateReceived,
                                                                    newReceivedDate: week14Dates['$idx-dateReceived'],
                                                                    initialReceivedVal: week14Vaccines[idx].received,
                                                                    newReceivedVal: week14ReceivedVals["$idx-receivedVal"],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(color: Color(0xff163C4D)),
                                                  DropdownButtonFormField(
                                                    decoration: inputDeco(week14Vaccines[idx].received ? "Received" : "Not Received"),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: Colors.deepOrange),
                                                    items: [
                                                      'Received',
                                                      'Not Received',
                                                    ].map(
                                                      (val) {
                                                        return DropdownMenuItem<String>(
                                                          value: val,
                                                          child: Text(val),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) async {
                                                      setState(() {
                                                        week14ReceivedChecks['$idx-hasReceivedChanged'] = true;
                                                        val == "Received"
                                                            ? week14ReceivedVals["$idx-receivedVal"] = true
                                                            : week14ReceivedVals["$idx-receivedVal"] = false;
                                                      });

                                                      await apiService.updateReceived(
                                                        vaccine: vaccine,
                                                        hasReceivedChanged: week14ReceivedChecks['$idx-hasReceivedChanged'],
                                                        newReceivedDate: week14Dates['$idx-dateReceived'],
                                                        initialReceivedDate: week14Vaccines[idx].dateReceived,
                                                        newReceivedVal: week14ReceivedVals["$idx-receivedVal"],
                                                        initialReceivedVal: week14Vaccines[idx].received,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    //month 6
                                    ...List.generate(
                                      month6Vaccines.length,
                                      (idx) {
                                        final vaccine = month6Vaccines[idx];
                                        return Column(
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
                                                              month6Dates['$idx-dateReceived'] == null
                                                                  ? month6Vaccines[idx].dateReceived == null
                                                                      ? ""
                                                                      : month6Vaccines[idx].dateReceived
                                                                  : month6Dates['$idx-dateReceived'],
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(Icons.date_range),
                                                            onTap: () {
                                                              DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions: true,
                                                                currentTime: DateTime.now(),
                                                                locale: LocaleType.en,
                                                                minTime: DateTime(1963, 3, 5),
                                                                maxTime: DateTime.now(),
                                                                onChanged: (date) {},
                                                                onConfirm: (date) async {
                                                                  setState(() {
                                                                    month6Dates['$idx-dateReceived'] = date.toString().split(' ').first;
                                                                  });
                                                                  await apiService.updateReceived(
                                                                    vaccine: vaccine,
                                                                    hasReceivedChanged: month6ReceivedChecks['$idx-hasReceivedChanged'],
                                                                    initialReceivedDate: month6Vaccines[idx].dateReceived,
                                                                    newReceivedDate: month6Dates['$idx-dateReceived'],
                                                                    initialReceivedVal: month6Vaccines[idx].received,
                                                                    newReceivedVal: month6ReceivedVals["$idx-receivedVal"],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(color: Color(0xff163C4D)),
                                                  DropdownButtonFormField(
                                                    decoration: inputDeco(month6Vaccines[idx].received ? "Received" : "Not Received"),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: Colors.deepOrange),
                                                    items: [
                                                      'Received',
                                                      'Not Received',
                                                    ].map(
                                                      (val) {
                                                        return DropdownMenuItem<String>(
                                                          value: val,
                                                          child: Text(val),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) async {
                                                      setState(() {
                                                        month6ReceivedChecks['$idx-hasReceivedChanged'] = true;
                                                        val == "Received"
                                                            ? month6ReceivedVals["$idx-receivedVal"] = true
                                                            : month6ReceivedVals["$idx-receivedVal"] = false;
                                                      });

                                                      await apiService.updateReceived(
                                                        vaccine: vaccine,
                                                        hasReceivedChanged: month6ReceivedChecks['$idx-hasReceivedChanged'],
                                                        newReceivedDate: month6Dates['$idx-dateReceived'],
                                                        initialReceivedDate: month6Vaccines[idx].dateReceived,
                                                        newReceivedVal: month6ReceivedVals["$idx-receivedVal"],
                                                        initialReceivedVal: month6Vaccines[idx].received,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    //month 7
                                    ...List.generate(
                                      month7Vaccines.length,
                                      (idx) {
                                        final vaccine = month7Vaccines[idx];
                                        return Column(
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
                                                              month7Dates['$idx-dateReceived'] == null
                                                                  ? month7Vaccines[idx].dateReceived == null
                                                                      ? ""
                                                                      : month7Vaccines[idx].dateReceived
                                                                  : month7Dates['$idx-dateReceived'],
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            child: Icon(Icons.date_range),
                                                            onTap: () {
                                                              DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions: true,
                                                                currentTime: DateTime.now(),
                                                                locale: LocaleType.en,
                                                                minTime: DateTime(1963, 3, 5),
                                                                maxTime: DateTime.now(),
                                                                onChanged: (date) {},
                                                                onConfirm: (date) async {
                                                                  setState(() {
                                                                    month7Dates['$idx-dateReceived'] = date.toString().split(' ').first;
                                                                  });
                                                                  await apiService.updateReceived(
                                                                    vaccine: vaccine,
                                                                    hasReceivedChanged: month7ReceivedChecks['$idx-hasReceivedChanged'],
                                                                    initialReceivedDate: month7Vaccines[idx].dateReceived,
                                                                    newReceivedDate: month7Dates['$idx-dateReceived'],
                                                                    initialReceivedVal: month7Vaccines[idx].received,
                                                                    newReceivedVal: month7ReceivedVals["$idx-receivedVal"],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(color: Color(0xff163C4D)),
                                                  DropdownButtonFormField(
                                                    decoration: inputDeco(month7Vaccines[idx].received ? "Received" : "Not Received"),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: Colors.deepOrange),
                                                    items: [
                                                      'Received',
                                                      'Not Received',
                                                    ].map(
                                                      (val) {
                                                        return DropdownMenuItem<String>(
                                                          value: val,
                                                          child: Text(val),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) async {
                                                      setState(() {
                                                        month7ReceivedChecks['$idx-hasReceivedChanged'] = true;
                                                        val == "Received"
                                                            ? month7ReceivedVals["$idx-receivedVal"] = true
                                                            : month7ReceivedVals["$idx-receivedVal"] = false;
                                                      });

                                                      await apiService.updateReceived(
                                                        vaccine: vaccine,
                                                        hasReceivedChanged: month7ReceivedChecks['$idx-hasReceivedChanged'],
                                                        newReceivedDate: month7Dates['$idx-dateReceived'],
                                                        initialReceivedDate: month7Vaccines[idx].dateReceived,
                                                        newReceivedVal: month7ReceivedVals["$idx-receivedVal"],
                                                        initialReceivedVal: month7Vaccines[idx].received,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is ScheduleDetailsError) {
            return Container(
              color: Colors.red,
              height: 40,
            );
          }
          return Container(
              height: 50,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              )));
        }),
      ),
    );
  }
}
