import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_bloc.dart';
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_state.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_state.dart';
import 'package:pocket_health/services/test_service.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScheduleDetailsScreen extends StatefulWidget {
  final id;

  const EditScheduleDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _EditScheduleDetailsScreenState createState() => _EditScheduleDetailsScreenState();
}

class _EditScheduleDetailsScreenState extends State<EditScheduleDetailsScreen> {
  String dateOfBirth;
  String received;

  final httpClient = http.Client();
  String atBirthVaccineReceived;
  String atBirthDate;
  String atBirthDateFormatted;
  String week6VaccineReceived;
  String week6Date;
  String week6DateFormatted;
  String week10VaccineReceived;
  String week10Date;
  String week10DateFormatted;
  String week14VaccineReceived;
  String week14Date;
  String week14DateFormatted;
  String month6VaccineReceived;
  String month6Date;
  String month6DateFormatted;
  String month7VaccineReceived;
  String month7Date;
  String month7DateFormatted;

  TextEditingController dob = new TextEditingController();
  TextEditingController name = new TextEditingController();

  getValuesFromSf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    atBirthVaccineReceived = prefs.getString('${widget.id}-atBirthVaccineReceived');
    atBirthDate = prefs.getString('${widget.id}-atBirthDate');
    week6VaccineReceived = prefs.getString('${widget.id}-week6VaccineReceived');
    week6Date = prefs.getString('${widget.id}-week6Date');
    week10VaccineReceived = prefs.getString('${widget.id}-week10VaccineReceived');
    week10Date = prefs.getString('${widget.id}-week10Date');
    week14VaccineReceived = prefs.getString('${widget.id}-week14VaccineReceived');
    week14Date = prefs.getString('${widget.id}-week14Date');
    month6VaccineReceived = prefs.getString('${widget.id}-month6VaccineReceived');
    month6Date = prefs.getString('${widget.id}-month6Date');
    month7VaccineReceived = prefs.getString('${widget.id}-month7VaccineReceived');
    month7Date = prefs.getString('${widget.id}-month7Date');
  }

  @override
  void initState() {
    super.initState();
    getValuesFromSf();
  }

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
                    BlocBuilder<AllSchedulesBloc, AllSchedulesState>(builder: (context, allState) {
                      if (allState is AllSchedulesLoaded) {
                        return Container(
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
                                //
                                // Future<Schedule> updateSchedule({int childId, int scheduleNo, int vaccineNo}) async {
                                //   final _token = await getStringValuesSF();
                                //   final scheduleJson = (allState.allSchedulesModel.where((element) => element.id == 18).toList()[0]).toJson();
                                //   final newJson = JsonPatch.apply(
                                //     scheduleJson,
                                //     [
                                //       {"op": "replace", "path": "/schedules/$scheduleNo/vaccines/$vaccineNo/received", "value": true}
                                //       //                 schedule index.    ^                    ^vaccine number
                                //     ],
                                //     strict: true,
                                //   );
                                //   final sdf = json.encode(newJson);
                                //   print('Object after applying patch operations: ${sdf}');
                                //   final response = await httpClient.put(
                                //     immunizationEndpoint + '18',
                                //     body: sdf,
                                //     headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
                                //   );
                                //   print('update response  | ' + '${response.body}');
                                //   return Schedule.fromJson(json.decode(response.body));
                                // }

                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                    child: Column(
                                      children: [
                                        //at birth
                                        ...List.generate(
                                          atBirthVaccines.length,
                                          (idx) {
                                            final vaccineNo = 'vaccine-no-$idx';
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
                                                                child: Align(
                                                                    alignment: Alignment.centerLeft, child: Text(atBirthVaccines[idx].schedule.toString())),
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
                                                                  '',
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
                                                                    maxTime: DateTime(2021, 6, 7),
                                                                    onChanged: (date) {},
                                                                    onConfirm: (date) async {
                                                                      setState(() {
                                                                        // atBirthDateFormatted = ;
                                                                        atBirthDate =
                                                                            '${widget.id}-atBirth-$vaccineNo-${DateFormat.MMMMEEEEd().format(DateTime.parse(date.toString()))}';
                                                                      });
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                      await prefs.setString('${widget.id}-atBirthDate', atBirthDate);
                                                                      print(prefs.getString('${widget.id}-atBirthDate'));
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
                                                        decoration: inputDeco(
                                                            atBirthVaccineReceived == '${widget.id}-atBirth-$vaccineNo-Received' ? "Received" : "Not Received"),
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
                                                            atBirthVaccineReceived = '${widget.id}-atBirth-$vaccineNo-$val';
                                                          });

                                                          // await updateSchedule(childId: 18, scheduleNo: 0, vaccineNo: idx);

                                                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          // await prefs.setString('${widget.id}-atBirthVaccineReceived', atBirthVaccineReceived);
                                                          // print(prefs.getString('${widget.id}-atBirthVaccineReceived'));
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
                                            final vaccineNo = 'vaccine-no-$idx';
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
                                                                child:
                                                                    Align(alignment: Alignment.centerLeft, child: Text(week6Vaccines[idx].schedule.toString())),
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
                                                                  week6Date != null
                                                                      ? week6Date.split('-')[4] == idx.toString()
                                                                          ? week6Date.split('-').last
                                                                          : ''
                                                                      : '',
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
                                                                    maxTime: DateTime(2021, 6, 7),
                                                                    onChanged: (date) {},
                                                                    onConfirm: (date) async {
                                                                      setState(() {
                                                                        week6DateFormatted = DateFormat.MMMMEEEEd().format(DateTime.parse(date.toString()));
                                                                        week6Date = '${widget.id}-atBirth-$vaccineNo-$week6DateFormatted';
                                                                      });
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                      await prefs.setString('${widget.id}-week6Date', week6Date);
                                                                      print(prefs.getString('${widget.id}-week6Date'));
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
                                                        decoration: inputDeco(
                                                            week6VaccineReceived == '${widget.id}-week6-$vaccineNo-Received' ? "Received" : "Not Received"),
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
                                                            week6VaccineReceived = '${widget.id}-week6-$vaccineNo-$val';
                                                          });

                                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          await prefs.setString('${widget.id}-week6VaccineReceived', week6VaccineReceived);
                                                          print(prefs.getString('${widget.id}-week6VaccineReceived'));
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
                                          atBirthVaccines.length,
                                          (idx) {
                                            final vaccineNo = 'vaccine-no-$idx';
                                            return Column(
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(minHeight: 10.h),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF00FFFF),
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Align(alignment: Alignment.centerLeft, child: Text('Week 10')),
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
                                                                child: Align(
                                                                    alignment: Alignment.centerLeft, child: Text(atBirthVaccines[idx].schedule.toString())),
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
                                                                  atBirthDate != null
                                                                      ? atBirthDate.split('-')[4] == idx.toString()
                                                                          ? atBirthDate.split('-').last
                                                                          : ''
                                                                      : '',
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
                                                                    maxTime: DateTime(2021, 6, 7),
                                                                    onChanged: (date) {},
                                                                    onConfirm: (date) async {
                                                                      setState(() {
                                                                        atBirthDateFormatted = DateFormat.MMMMEEEEd().format(DateTime.parse(date.toString()));
                                                                        atBirthDate = '${widget.id}-atBirth-$vaccineNo-$atBirthDateFormatted';
                                                                      });
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                      await prefs.setString('${widget.id}-atBirthDate', atBirthDate);
                                                                      print(prefs.getString('${widget.id}-atBirthDate'));
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
                                                        decoration: inputDeco(
                                                            atBirthVaccineReceived == '${widget.id}-atBirth-$vaccineNo-Received' ? "Received" : "Not Received"),
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
                                                            atBirthVaccineReceived = '${widget.id}-atBirth-$vaccineNo-$val';
                                                          });

                                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          await prefs.setString('${widget.id}-atBirthVaccineReceived', atBirthVaccineReceived);
                                                          print(prefs.getString('${widget.id}-atBirthVaccineReceived'));
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
                                          atBirthVaccines.length,
                                          (idx) {
                                            final vaccineNo = 'vaccine-no-$idx';
                                            return Column(
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(minHeight: 10.h),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF00FFFF),
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Align(alignment: Alignment.centerLeft, child: Text('Week 14')),
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
                                                                child: Align(
                                                                    alignment: Alignment.centerLeft, child: Text(atBirthVaccines[idx].schedule.toString())),
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
                                                                  atBirthDate != null
                                                                      ? atBirthDate.split('-')[4] == idx.toString()
                                                                          ? atBirthDate.split('-').last
                                                                          : ''
                                                                      : '',
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
                                                                    maxTime: DateTime(2021, 6, 7),
                                                                    onChanged: (date) {},
                                                                    onConfirm: (date) async {
                                                                      setState(() {
                                                                        atBirthDateFormatted = DateFormat.MMMMEEEEd().format(DateTime.parse(date.toString()));
                                                                        atBirthDate = '${widget.id}-atBirth-$vaccineNo-$atBirthDateFormatted';
                                                                      });
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                      await prefs.setString('${widget.id}-atBirthDate', atBirthDate);
                                                                      print(prefs.getString('${widget.id}-atBirthDate'));
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
                                                        decoration: inputDeco(
                                                            atBirthVaccineReceived == '${widget.id}-atBirth-$vaccineNo-Received' ? "Received" : "Not Received"),
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
                                                            atBirthVaccineReceived = '${widget.id}-atBirth-$vaccineNo-$val';
                                                          });

                                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          await prefs.setString('${widget.id}-atBirthVaccineReceived', atBirthVaccineReceived);
                                                          print(prefs.getString('${widget.id}-atBirthVaccineReceived'));
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
                                          atBirthVaccines.length,
                                          (idx) {
                                            final vaccineNo = 'vaccine-no-$idx';
                                            return Column(
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(minHeight: 10.h),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF00FFFF),
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Align(alignment: Alignment.centerLeft, child: Text('Month 6')),
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
                                                                child: Align(
                                                                    alignment: Alignment.centerLeft, child: Text(atBirthVaccines[idx].schedule.toString())),
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
                                                                  atBirthDate != null
                                                                      ? atBirthDate.split('-')[4] == idx.toString()
                                                                          ? atBirthDate.split('-').last
                                                                          : ''
                                                                      : '',
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
                                                                    maxTime: DateTime(2021, 6, 7),
                                                                    onChanged: (date) {},
                                                                    onConfirm: (date) async {
                                                                      setState(() {
                                                                        atBirthDateFormatted = DateFormat.MMMMEEEEd().format(DateTime.parse(date.toString()));
                                                                        atBirthDate = '${widget.id}-atBirth-$vaccineNo-$atBirthDateFormatted';
                                                                      });
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                      await prefs.setString('${widget.id}-atBirthDate', atBirthDate);
                                                                      print(prefs.getString('${widget.id}-atBirthDate'));
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
                                                        decoration: inputDeco(
                                                            atBirthVaccineReceived == '${widget.id}-atBirth-$vaccineNo-Received' ? "Received" : "Not Received"),
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
                                                            atBirthVaccineReceived = '${widget.id}-atBirth-$vaccineNo-$val';
                                                          });

                                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          await prefs.setString('${widget.id}-atBirthVaccineReceived', atBirthVaccineReceived);
                                                          print(prefs.getString('${widget.id}-atBirthVaccineReceived'));
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
                                          atBirthVaccines.length,
                                          (idx) {
                                            final vaccineNo = 'vaccine-no-$idx';
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
                                                                child: Align(
                                                                    alignment: Alignment.centerLeft, child: Text(atBirthVaccines[idx].schedule.toString())),
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
                                                                  atBirthDate != null
                                                                      ? atBirthDate.split('-')[4] == idx.toString()
                                                                          ? atBirthDate.split('-').last
                                                                          : ''
                                                                      : '',
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
                                                                    maxTime: DateTime(2021, 6, 7),
                                                                    onChanged: (date) {},
                                                                    onConfirm: (date) async {
                                                                      setState(() {
                                                                        atBirthDateFormatted = DateFormat.MMMMEEEEd().format(DateTime.parse(date.toString()));
                                                                        atBirthDate = '${widget.id}-atBirth-$vaccineNo-$atBirthDateFormatted';
                                                                      });
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                      await prefs.setString('${widget.id}-atBirthDate', atBirthDate);
                                                                      print(prefs.getString('${widget.id}-atBirthDate'));
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
                                                        decoration: inputDeco(
                                                            atBirthVaccineReceived == '${widget.id}-atBirth-$vaccineNo-Received' ? "Received" : "Not Received"),
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
                                                          test();

                                                          // setState(() {
                                                          //   atBirthVaccineReceived = '${widget.id}-atBirth-$vaccineNo-$val';
                                                          // });
                                                          //
                                                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          // await prefs.setString('${widget.id}-atBirthVaccineReceived', atBirthVaccineReceived);
                                                          // print(prefs.getString('${widget.id}-atBirthVaccineReceived'));
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
                        );
                      } else
                        return null;
                    })
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
