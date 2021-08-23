import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/appointments/appointments_cubit.dart';
import 'package:pocket_health/bloc/booking_history/booking_history_cubit.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/utils/constants.dart';

import 'appointment_booked_dialog.dart';

class BookAppointmentScreen extends StatefulWidget {
  final PractitionerProfileModel practitionerModel;
  final int userID;
  BookAppointmentScreen({Key key, @required this.practitionerModel, this.userID}) : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.parse(DateTime.now()?.toString()?.split(" ")?.first);

  TabController _tabController;
  int appointmentTypeVal;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    context.read<BookingHistoryCubit>().fetchAppointments(docID: widget.practitionerModel.user, userID: widget.userID);
  }

  // final List appointments =;

  List<String> tags = [];

  List<String> morningOptions = [
    '06:00:00 - 06:15:00',
    '06:15:00 - 06:30:00',
    '06:30:00 - 06:45:00',
    '06:45:00 - 07:00:00',
    '07:00:00 - 07:15:00',
    '07:15:00 - 07:30:00',
    '07:30:00 - 07:45:00',
    '07:45:00 - 08:00:00',
    '08:00:00 - 08:15:00',
    '08:15:00 - 08:30:00',
    '08:30:00 - 08:45:00',
    '08:45:00 - 09:00:00',
    '09:00:00 - 09:15:00',
    '09:15:00 - 09:30:00',
    '09:30:00 - 09:45:00',
    '09:45:00 - 10:00:00',
    '10:00:00 - 10:15:00',
    '10:15:00 - 10:30:00',
    '10:30:00 - 10:45:00',
    '10:45:00 - 11:00:00',
    '11:00:00 - 11:15:00',
    '11:15:00 - 11:30:00',
    '11:30:00 - 11:45:00',
    '11:45:00 - 12:00:00',
  ];

  List<String> afternoonOptions = [
    '12:00:00 - 12:15:00',
    '12:15:00 - 12:30:00',
    '12:30:00 - 12:45:00',
    '12:45:00 - 13:00:00',
    '13:00:00 - 13:15:00',
    '13:15:00 - 13:30:00',
    '13:30:00 - 13:45:00',
    '13:45:00 - 14:00:00',
    '14:00:00 - 14:15:00',
    '14:15:00 - 14:30:00',
    '14:30:00 - 14:45:00',
    '14:45:00 - 15:00:00',
    '15:00:00 - 15:15:00',
    '15:15:00 - 15:30:00',
    '15:30:00 - 15:45:00',
    '15:45:00 - 16:00:00',
    '16:00:00 - 16:15:00',
    '16:15:00 - 16:30:00',
    '16:30:00 - 16:45:00',
    '16:45:00 - 17:00:00',
  ];

  List<String> eveningOptions = [
    '17:00:00 - 17:15:00',
    '17:15:00 - 17:30:00',
    '17:30:00 - 17:45:00',
    '17:45:00 - 18:00:00',
    '18:00:00 - 18:15:00',
    '18:15:00 - 18:30:00',
    '18:30:00 - 18:45:00',
    '18:45:00 - 19:00:00',
    '19:00:00 - 19:15:00',
    '19:15:00 - 19:30:00',
    '19:30:00 - 19:45:00',
    '19:45:00 - 20:00:00',
    '20:00:00 - 20:15:00',
    '20:15:00 - 20:30:00',
    '20:30:00 - 20:45:00',
    '20:45:00 - 21:00:00',
    '21:00:00 - 21:15:00',
    '21:15:00 - 21:30:00',
    '21:30:00 - 21:45:00',
    '21:45:00 - 22:00:00',
  ];

  List<double> compareMorningTime = [
    6,
    6.25,
    6.5,
    6.75,
    7,
    7.25,
    7.5,
    7.75,
    8,
    8.25,
    8.5,
    8.75,
    9,
    9.25,
    9.5,
    9.75,
    10,
    10.25,
    10.5,
    10.75,
    11,
    11.25,
    11.5,
    11.75,
    12,
  ];

  List<double> compareAfternoonTime = [
    12,
    12.25,
    12.5,
    12.75,
    13,
    13.25,
    13.5,
    13.75,
    14,
    14.25,
    14.5,
    14.75,
    15,
    15.25,
    15.5,
    15.75,
    16,
    16.25,
    16.5,
    16.75,
    17,
  ];

  List<double> compareEveningTime = [
    17,
    17.25,
    17.5,
    18.75,
    18,
    18.25,
    18.5,
    18.75,
    19,
    19.25,
    19.5,
    19.75,
    20,
    20.25,
    20.5,
    20.75,
    21,
    21.25,
    21.5,
    21.75,
    22,
  ];

  @override
  Widget build(BuildContext context) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    // print('${}');

    return SafeArea(
      child: Scaffold(
        backgroundColor: accentColorLight,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Book Appointment',
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 15.w),
          child: Column(
            children: [
              //details
              BlocConsumer<BookingHistoryCubit, BookingHistoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is BookingHistoryLoading) {
                    return Container(height: 200.h, child: Center(child: CircularProgressIndicator()));
                  }
                  if (state is BookingHistoryFailure) {
                    return Container(height: 100, width: 100, color: Colors.red);
                  }
                  if (state is BookingHistorySuccess) {
                    return Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6.w), bottomRight: Radius.circular(8.w)),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //practitioner
                              Container(
                                width: 384.w,
                                padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.w), topRight: Radius.circular(8.w)),
                                  color: accentColorDark,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dr. Darren Elder',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Ho-ho-ho! love of faith.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //date
                              Material(
                                color: Colors.white,
                                child: InkWell(
                                  splashColor: accentColorLight,
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    dense: true,
                                    visualDensity: VisualDensity.compact,
                                    onTap: () async {},
                                    title: Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff373737),
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat.MMMMEEEEd().format(selectedDate).toString(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff707070),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        MdiIcons.calendar,
                                        size: 24.r,
                                        color: Color(0xff515050),
                                      ),
                                      onPressed: () async {
                                        final DateTime picked = await showDatePicker(
                                          context: context,
                                          initialDate: selectedDate,
                                          firstDate: DateTime(1930),
                                          lastDate: DateTime(2022),
                                          currentDate: DateTime.now(),
                                          builder: (BuildContext context, Widget child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme: ColorScheme.fromSwatch(
                                                  primarySwatch: Colors.teal,
                                                  primaryColorDark: Colors.teal,
                                                  accentColor: Colors.tealAccent,
                                                ),
                                                dialogBackgroundColor: Colors.white,
                                              ),
                                              child: child,
                                            );
                                          },
                                        );

                                        if (picked != null && picked != selectedDate) {
                                          setState(() {
                                            selectedDate = DateTime.parse(picked?.toString()?.split(" ")?.first);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),
                              SizedBox(height: 8.h),

                              //type
                              Padding(
                                padding: EdgeInsets.only(left: 15.w, top: 4.w),
                                child: Text(
                                  'Type of appointment',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff373737),
                                  ),
                                ),
                              ),
                              DropdownButtonFormField(
                                isExpanded: true,
                                elevation: 1,
                                menuMaxHeight: 0.5.sh,
                                dropdownColor: Colors.white,
                                iconSize: 23.r,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff707070),
                                  fontWeight: FontWeight.w600,
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 23.r,
                                  color: Color(0xff515050),
                                ),
                                hint: Text(
                                  'What type of apppointment suits you?',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0xff707070),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                                ),
                                items: [
                                  'None',
                                  'Online Appointment',
                                  'Regular Appointment In Person',
                                  'Follow-up Appointment In Person',
                                ]
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => DropdownMenuItem(
                                        value: entry.key,
                                        child: FittedBox(
                                          child: Text(
                                            entry.value,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  print('--------|appointmentVal|--------|value -> ${val.toString()}');
                                  setState(() {
                                    appointmentTypeVal = val;
                                  });
                                },
                              ),
                              SizedBox(height: 8.h),
                              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),
                              SizedBox(height: 15.h),

                              Padding(
                                padding: EdgeInsets.only(left: 15.w, bottom: 15.w),
                                child: Text(
                                  "Select Session",
                                  style: sectionTitle,
                                ),
                              ),

                              //tabs
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: ButtonsTabBar(
                                        controller: _tabController,
                                        backgroundColor: accentColorDark,
                                        height: 32.h,
                                        duration: 150,
                                        radius: 4.r,
                                        labelSpacing: 0.0,
                                        buttonMargin: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 8.w),
                                        unselectedBackgroundColor: Colors.grey[300],
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        unselectedLabelStyle: TextStyle(
                                          color: Color(0xff777a7e),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        tabs: [
                                          Tab(text: 'Morning'),
                                          Tab(text: 'Afternoon'),
                                          Tab(text: 'Evening'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: _tabController.index == 0
                                        ? 730.h
                                        : _tabController.index == 1
                                            ? 610.h
                                            : 610.h,
                                    child: TabBarView(
                                      controller: _tabController,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        //morning
                                        ChipsChoice.multiple(
                                          value: tags,
                                          onChanged: (val) {},
                                          wrapped: true,
                                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                                          spacing: 15.w,
                                          mainAxisSize: MainAxisSize.max,
                                          wrapCrossAlignment: WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          runSpacing: 15.w,
                                          choiceItems: C2Choice.listFrom<String, String>(
                                            source: morningOptions,
                                            value: (index, label) => label,
                                            label: (index, label) => label.replaceRange(5, 8, '').replaceRange(13, 16, ''),
                                            disabled: (index, label) {
                                              final bookedOnThisDate = state.bookings.where((e) => e.appointmentDate == selectedDate).toList();
                                              final thisHour = DateTime.now().hour;
                                              final time = DateTime.now().minute >= 45
                                                  ? thisHour + 0.75
                                                  : DateTime.now().minute >= 30
                                                  ? thisHour + 0.5
                                                  : DateTime.now().minute >= 15
                                                  ? thisHour + 0.25
                                                  : thisHour + 0.01;
                                              final bool isBooked =
                                                  bookedOnThisDate.where((e) => ("${e.timeSlotFrom} - ${e.timeSlotTo}") == label).toList().isNotEmpty;

                                              final bool timePassed =
                                                  time >= compareMorningTime[index] && DateTime.parse(selectedDate.toString()).day == DateTime.now().day;

                                              // print("$index is booked ----------" + (isBooked).toString());
                                              // print("$index time passed --------" + (timePassed).toString());
                                              // print("$index both and -----------" + (timePassed && isBooked).toString());
                                              // print("$index both or ------------" + (timePassed || isBooked).toString());
                                              final bool isDisabled = (timePassed || isBooked) == true;
                                              return isDisabled;
                                            },
                                          ),
                                          choiceBuilder: (item) {
                                            return InkWell(
                                              onTap: item.disabled
                                                  ? () {}
                                                  : tags.contains(item.value)
                                                  ? () {
                                                setState(() {
                                                  tags.remove(item.value);
                                                });
                                              }
                                                  : () {
                                                setState(() {
                                                  tags.add(item.value);
                                                });
                                              },
                                              child: Visibility(
                                                visible: item.selected,
                                                //when not selected
                                                replacement: item.disabled

                                                //when disabled
                                                    ? AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: Colors.black26,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xff707070),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )

                                                //when not disabled
                                                    : AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: accentColorDark,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      color: accentColorDark,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),

                                                //selected
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: accentColorDark,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: accentColorDark,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        //afternoon
                                        ChipsChoice.multiple(
                                          value: tags,
                                          onChanged: (val) {},
                                          wrapped: true,
                                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                                          spacing: 15.w,
                                          mainAxisSize: MainAxisSize.max,
                                          wrapCrossAlignment: WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          runSpacing: 15.w,
                                          choiceItems: C2Choice.listFrom<String, String>(
                                            source: afternoonOptions,
                                            value: (index, label) => label,
                                            label: (index, label) => label.replaceRange(5, 8, '').replaceRange(13, 16, ''),
                                            disabled: (index, label) {
                                              final bookedOnThisDate = state.bookings.where((e) => e.appointmentDate == selectedDate).toList();
                                              final thisHour = DateTime.now().hour;
                                              final time = DateTime.now().minute >= 45
                                                  ? thisHour + 0.75
                                                  : DateTime.now().minute >= 30
                                                  ? thisHour + 0.5
                                                  : DateTime.now().minute >= 15
                                                  ? thisHour + 0.25
                                                  : thisHour + 0.01;
                                              final bool isBooked =
                                                  bookedOnThisDate.where((e) => ("${e.timeSlotFrom} - ${e.timeSlotTo}") == label).toList().isNotEmpty;

                                              final bool timePassed =
                                                  time >= compareAfternoonTime[index] && DateTime.parse(selectedDate.toString()).day == DateTime.now().day;

                                              final bool isDisabled = (timePassed || isBooked) == true;
                                              return isDisabled;
                                            },
                                          ),
                                          choiceBuilder: (item) {
                                            return InkWell(
                                              onTap: item.disabled
                                                  ? () {}
                                                  : tags.contains(item.value)
                                                  ? () {
                                                setState(() {
                                                  tags.remove(item.value);
                                                });
                                              }
                                                  : () {
                                                setState(() {
                                                  tags.add(item.value);
                                                });
                                              },
                                              child: Visibility(
                                                visible: item.selected,
                                                //when not selected
                                                replacement: item.disabled

                                                //when disabled
                                                    ? AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: Colors.black26,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xff707070),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )

                                                //when not disabled
                                                    : AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: accentColorDark,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      color: accentColorDark,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),

                                                //selected
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: accentColorDark,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: accentColorDark,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        //evening
                                        ChipsChoice.multiple(
                                          value: tags,
                                          onChanged: (val) {},
                                          wrapped: true,
                                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                                          spacing: 15.w,
                                          mainAxisSize: MainAxisSize.max,
                                          wrapCrossAlignment: WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          runSpacing: 15.w,
                                          choiceItems: C2Choice.listFrom<String, String>(
                                            source: eveningOptions,
                                            value: (index, label) => label,
                                            label: (index, label) => label.replaceRange(5, 8, '').replaceRange(13, 16, ''),
                                            disabled: (index, label) {
                                              final bookedOnThisDate = state.bookings.where((e) => e.appointmentDate == selectedDate).toList();
                                              final thisHour = DateTime.now().hour;
                                              final time = DateTime.now().minute >= 45
                                                  ? thisHour + 0.75
                                                  : DateTime.now().minute >= 30
                                                  ? thisHour + 0.5
                                                  : DateTime.now().minute >= 15
                                                  ? thisHour + 0.25
                                                  : thisHour + 0.01;
                                              final bool isBooked =
                                                  bookedOnThisDate.where((e) => ("${e.timeSlotFrom} - ${e.timeSlotTo}") == label).toList().isNotEmpty;

                                              final bool timePassed =
                                                  time >= compareEveningTime[index] && DateTime.parse(selectedDate.toString()).day == DateTime.now().day;

                                              final bool isDisabled = (timePassed || isBooked) == true;
                                              return isDisabled;
                                            },
                                          ),
                                          choiceBuilder: (item) {
                                            return InkWell(
                                              onTap: item.disabled
                                                  ? () {}
                                                  : tags.contains(item.value)
                                                  ? () {
                                                setState(() {
                                                  tags.remove(item.value);
                                                });
                                              }
                                                  : () {
                                                setState(() {
                                                  tags.add(item.value);
                                                });
                                              },
                                              child: Visibility(
                                                visible: item.selected,
                                                //when not selected
                                                replacement: item.disabled

                                                //when disabled
                                                    ? AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: Colors.black26,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Color(0xff707070),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )

                                                //when not disabled
                                                    : AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: accentColorDark,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      color: accentColorDark,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),

                                                //selected
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 150),
                                                  width: 153.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: accentColorDark,
                                                    border: Border.all(
                                                      width: 1.w,
                                                      color: accentColorDark,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                                  child: Text(
                                                    item.label,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),

              //book btn
              BlocConsumer<AppointmentsCubit, AppointmentsState>(
                listenWhen: (prev, curr) => prev == curr ? false : true,
                listener: (context, state) {
                  if (state is AppointmentsFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color(0xff163C4D),
                        duration: Duration(milliseconds: 6000),
                        content: Text(
                          'Failed booking an appointment. Try again!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is AppointmentsSuccess) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return AppointmentBookedDialog();
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return MaterialButton(
                    color: accentColorDark,
                    elevation: 0.0,
                    height: 40.0.h,
                    minWidth: 376.w,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                    child: state is AppointmentsLoading
                        ? SizedBox(height: 20.h, width: 20.h, child: CircularProgressIndicator())
                        : Text(
                      'BOOK APPOINTMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: state is AppointmentsLoading
                        ? () {}
                        : () async {
                            appointmentTypeVal == null
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Color(0xff163C4D),
                                      duration: Duration(milliseconds: 6000),
                                      content: Text(
                                        'Please pick the type of appointment you prefer',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                : tags.forEach((tag) {
                                    print(tag);
                                    final slotFrom = tag.split(' - ').first;
                                    final slotTo = tag.split(' - ').last;
                                    context.read<AppointmentsCubit>()
                                      ..bookAppointment(
                                        appointmentDate: selectedDate,
                                        slotFrom: slotFrom,
                                        slotTo: slotTo,
                                        status: 3,
                                        appointmentType: appointmentTypeVal,
                                        userID: 1,
                                        //TODO : Production | change to dynamic val
                                        docID: widget.practitionerModel.user,
                                      );
                                  });
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
