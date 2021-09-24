import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/accept_decline/accept_decline_cubit.dart';
import 'package:pocket_health/bloc/manage_bookings/manage_bookings_cubit.dart';
import 'package:pocket_health/screens/Appointments/bookings_list_view.dart';
import 'package:pocket_health/utils/constants.dart';

class ManageAppointments extends StatefulWidget {
  const ManageAppointments({Key key}) : super(key: key);

  @override
  _ManageAppointmentsState createState() => _ManageAppointmentsState();
}

class _ManageAppointmentsState extends State<ManageAppointments> with SingleTickerProviderStateMixin {
  TabController _tabController;

  DatePickerController _controller = DatePickerController();

  bool pendingSelected = true;
  bool acceptedSelected = false;
  bool declinedSelected = false;
  bool allSelected = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noneSelected = (pendingSelected == false && allSelected == false && acceptedSelected == false && declinedSelected == false);
    return BlocListener<AcceptDeclineCubit, AcceptDeclineState>(
      listener: (context, state) {
        if (state is AcceptDeclineSuccess) {
          context.read<ManageBookingsCubit>()..loadBookingsById(4);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff1A5864),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                brightness: Brightness.dark,
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xff1A5864),
                elevation: 0.0,
                stretch: true,
                floating: false,
                title: Text(
                  'My Bookings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                expandedHeight: 194.h,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                  ],
                  background: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w, bottom: 16.0.w, top: 48.h),
                        child: DatePicker(
                          DateTime.now(),
                          width: 60.w,
                          height: 80.h,
                          dateTextStyle: TextStyle(
                            color: accentColorLight,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                          monthTextStyle: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                          dayTextStyle: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                          controller: _controller,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: accentColorLight,
                          selectedTextColor: Color(0xff1A5864),
                          inactiveDates: [],
                          onDateChange: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FilterChip(
                              elevation: 0.0,
                              selected: pendingSelected,
                              labelStyle: TextStyle(
                                color: accentColorDark,
                              ),
                              side: BorderSide(color: accentColorDark),
                              showCheckmark: true,
                              pressElevation: 0.0,
                              onSelected: (val) {
                                setState(() {
                                  pendingSelected = val;

                                  allSelected = false;
                                  acceptedSelected = false;
                                  declinedSelected = false;
                                });
                              },
                              checkmarkColor: accentColorDark,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: accentColorLight,
                              selectedColor: accentColorLight,
                              shape: StadiumBorder(),
                              labelPadding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.w),
                              label: Text(
                                'Pending',
                              ),
                            ),
                            SizedBox(width: 4.w),
                            FilterChip(
                              elevation: 0.0,
                              selected: acceptedSelected,
                              labelStyle: TextStyle(
                                color: accentColorDark,
                              ),
                              side: BorderSide(color: accentColorDark),
                              showCheckmark: true,
                              pressElevation: 0.0,
                              onSelected: (val) {
                                setState(() {
                                  acceptedSelected = val;

                                  allSelected = false;

                                  pendingSelected = false;
                                  declinedSelected = false;
                                });
                              },
                              checkmarkColor: accentColorDark,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: accentColorLight,
                              selectedColor: accentColorLight,
                              shape: StadiumBorder(),
                              labelPadding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.w),
                              label: Text(
                                'Accepted',
                              ),
                            ),
                            SizedBox(width: 4.w),
                            FilterChip(
                              elevation: 0.0,
                              selected: declinedSelected,
                              labelStyle: TextStyle(
                                color: accentColorDark,
                              ),
                              side: BorderSide(color: accentColorDark),
                              showCheckmark: true,
                              pressElevation: 0.0,
                              onSelected: (val) {
                                setState(() {
                                  declinedSelected = val;

                                  allSelected = false;
                                  acceptedSelected = false;
                                  pendingSelected = false;
                                });
                              },
                              checkmarkColor: accentColorDark,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: accentColorLight,
                              selectedColor: accentColorLight,
                              shape: StadiumBorder(),
                              labelPadding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.w),
                              label: Text(
                                'Declined',
                              ),
                            ),
                            SizedBox(width: 4.w),
                            FilterChip(
                              elevation: 0.0,
                              selected: noneSelected ? true : allSelected,
                              labelStyle: TextStyle(
                                color: accentColorDark,
                              ),
                              side: BorderSide(color: accentColorDark),
                              showCheckmark: true,
                              pressElevation: 0.0,
                              onSelected: (val) {
                                setState(() {
                                  allSelected = val;

                                  declinedSelected = false;
                                  acceptedSelected = false;
                                  pendingSelected = false;
                                });
                              },
                              checkmarkColor: accentColorDark,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: accentColorLight,
                              selectedColor: accentColorLight,
                              shape: StadiumBorder(),
                              labelPadding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.w),
                              label: Text(
                                'All',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return BlocBuilder<ManageBookingsCubit, ManageBookingsState>(
                      builder: (context, state) {
                        if (state is ManageBookingsFailure) {
                          return Container(
                            height: 24.h,
                            width: 24.h,
                            color: Colors.red,
                          );
                        }
                        if (state is ManageBookingsLoading) {
                          return Center(
                            child: Container(
                              height: 24.h,
                              width: 24.h,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is ManageBookingsSuccess) {
                          final allBookings = state.allBookings
                              .where((element) =>
                                  (element.appointmentDate.day == _selectedDate.day) &&
                                  (element.appointmentDate.year == _selectedDate.year) &&
                                  (element.appointmentDate.month == _selectedDate.month))
                              .toList();
                          final pendingBookings = state.pending
                              .where((element) =>
                                  (element.appointmentDate.day == _selectedDate.day) &&
                                  (element.appointmentDate.year == _selectedDate.year) &&
                                  (element.appointmentDate.month == _selectedDate.month))
                              .toList();
                          final acceptedBookings = state.accepted
                              .where((element) =>
                                  (element.appointmentDate.day == _selectedDate.day) &&
                                  (element.appointmentDate.year == _selectedDate.year) &&
                                  (element.appointmentDate.month == _selectedDate.month))
                              .toList();
                          final declinedBookings = state.declined
                              .where((element) =>
                                  (element.appointmentDate.day == _selectedDate.day) &&
                                  (element.appointmentDate.year == _selectedDate.year) &&
                                  (element.appointmentDate.month == _selectedDate.month))
                              .toList();

                          return BookingsListView(
                            date: _selectedDate,
                            docBookings: allSelected || noneSelected
                                ? allBookings
                                : pendingSelected
                                    ? pendingBookings
                                    : acceptedSelected
                                        ? acceptedBookings
                                        : declinedSelected
                                            ? declinedBookings
                                            : [],
                          );
                        }
                        return Container();
                      },
                    );
                  },
                  childCount: 1,
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
