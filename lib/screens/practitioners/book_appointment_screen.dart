import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/utils/constants.dart';

import 'appointment_booked_dialog.dart';

class BookAppointmentScreen extends StatefulWidget {
  final PractitionerProfileModel practitionerModel;

  BookAppointmentScreen({Key key, @required this.practitionerModel}) : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();

  final List appointments = [
    '1 min - 15 mins      -    KSH 2,500',
    '15 mins - 30 mins    -    KSH 2,500',
    '1 min - 15 mins      -    KSH 2,500',
  ];

  final List<String> tags = [];

  final List<String> morningOptions = [
    '09:00 - 09:15',
    '09:15 - 09:30',
    '09:30 - 09:45',
    '09:45 - 10:00',
    '10:00 - 10:15',
    '10:15 - 10:30',
    '10:30 - 10:45',
    '10:45 - 11:00',
    '11:15 - 11:30',
    '11:30 - 11:45',
    '11:45 - 12:00',
  ];

  final List<String> afternoonOptions = [
    '12:00 - 12:15',
    '12:15 - 12:30',
    '12:30 - 12:45',
    '12:45 - 1:00',
    '1:00 - 1:15',
    '1:15 - 1:30',
    '1:30 - 1:45',
    '1:45 - 2:00',
    '2:15 - 2:30',
    '2:30 - 2:45',
    '2:45 - 3:00',
    '3:00 - 3:15',
    '3:15 - 3:30',
    '3:30 - 3:45',
    '3:45 - 4:00',
    '4:15 - 4:30',
    '4:30 - 4:45',
    '4:45 - 5:00',
  ];

  final List<String> eveningOptions = [
    '5:00 - 5:15',
    '5:15 - 5:30',
    '5:30 - 5:45',
    '6:45 - 6:00',
    '6:00 - 6:15',
    '6:15 - 6:30',
    '6:30 - 6:45',
    '6:45 - 7:00',
  ];

  @override
  Widget build(BuildContext context) {
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
              Padding(
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
                              onTap: () async {
                                final DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1930),
                                  lastDate: DateTime(2022),
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

                                if (picked != null && picked != selectedDate)
                                  setState(() {
                                    selectedDate = picked;
                                  });
                              },
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
                                onPressed: () {},
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
                            // isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                          ),
                          items: appointments
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
                          onChanged: (val) {},
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
                        DefaultTabController(
                          length: 3,
                          child: Column(
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
                                height: 550.0.h,
                                child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    //morning
                                    Container(
                                      height: 550.0.h,
                                      width: 1.sw,
                                      child: ChipsChoice.multiple(
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
                                          value: (i, v) => v,
                                          label: (i, v) => v,
                                        ),
                                        choiceBuilder: (item) {
                                          return AnimatedContainer(
                                            duration: Duration(milliseconds: 150),
                                            width: 153.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: accentColorDark,
                                              borderRadius: BorderRadius.circular(10.w),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                            child: Text(
                                              item.label,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    //afternoon
                                    Container(
                                      width: 1.sw,
                                      child: ChipsChoice.multiple(
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
                                          value: (i, v) => v,
                                          label: (i, v) => v,
                                        ),
                                        choiceBuilder: (item) {
                                          return AnimatedContainer(
                                            duration: Duration(milliseconds: 150),
                                            width: 153.w,
                                            decoration: BoxDecoration(
                                              color: accentColorDark,
                                              borderRadius: BorderRadius.circular(10.w),
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                            child: Text(
                                              item.label,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    //evening
                                    Container(
                                      width: 1.sw,
                                      child: ChipsChoice.multiple(
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
                                          value: (i, v) => v,
                                          label: (i, v) => v,
                                        ),
                                        choiceBuilder: (item) {
                                          return AnimatedContainer(
                                            duration: Duration(milliseconds: 150),
                                            width: 153.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: accentColorDark,
                                              borderRadius: BorderRadius.circular(10.w),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.w),
                                            child: Text(
                                              item.label,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          );
                                        },
                                      ),
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
                ),
              ),
              //book btn

              MaterialButton(
                color: accentColorDark,
                elevation: 0.0,
                height: 40.0.h,
                minWidth: 376.w,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                child: Text(
                  'BOOK APPOINTMENT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext dialogContext) {
                      return AppointmentBookedDialog();
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
