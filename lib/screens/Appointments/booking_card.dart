import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/accept_decline/accept_decline_cubit.dart';
import 'package:pocket_health/models/doc_bookings.dart';
import 'package:pocket_health/screens/Appointments/user_profile_model.dart';
import 'package:pocket_health/services/api_service.dart';

class BookingCard extends StatefulWidget {
  final DocBookings booking;
  final DateTime date;

  const BookingCard({Key key, this.booking, this.date}) : super(key: key);

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  String profileURL = "";
  String surname = "";

  Future<UserProfileModel> getUserDetails(id) async {
    final _token = await getStringValuesSF();
    final response = await http.get(
      "https://ssential.herokuapp.com/api/user/profile",
      headers: {
        'Authorization': 'Bearer ' + _token,
        'Content-Type': 'application/json',
      },
    );
    final users = userProfileModelFromJson(response.body);
    final user = users.lastWhere((element) => element.user == id);
    setState(() {
      profileURL = user.profileImgUrl;
      surname = user.surname;
    });
    return user;
  }

  @override
  void initState() {
    super.initState();
    getUserDetails(widget.booking.user);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10.w),
        //time
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.booking.timeSlotFrom.split(":").first + ":" + widget.booking.timeSlotFrom.split(":")[1],
              style: TextStyle(
                color: Color(0xff081D21),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            Text(
              'FROM',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              widget.booking.timeSlotTo.split(":").first + ":" + widget.booking.timeSlotTo.split(":")[1],
              style: TextStyle(
                color: Color(0xff081D21),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            Text(
              'TO',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            //seperator
            Container(color: Colors.black12, width: 320.w, height: 1.h),

            SizedBox(height: 10.h),

            //patient
            Container(
              width: 320.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xC000000),
                    blurRadius: 6.w,
                    spreadRadius: 3.w,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25.w,
                          backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/3.jpg"),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              surname == "" || surname == null ? "surname_null" : surname,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff081D21),
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.booking.appointmentType == 1
                                  ? "Type: Online Booking"
                                  : widget.booking.appointmentType == 2
                                      ? "Type: Appointment In Person"
                                      : "Type: Follow Up Appointment",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff081d21),
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 58.w),
                          child: MaterialButton(
                            color: Color(0xffFFEEEF),
                            elevation: 0.0,
                            highlightElevation: 0.0,
                            focusElevation: 0.0,
                            disabledElevation: 0.0,
                            hoverElevation: 0.0,
                            height: 32.h,
                            minWidth: 111.w,
                            onPressed: () {
                              context.read<AcceptDeclineCubit>()
                                ..decline(
                                  patientID: 9,
                                  phoneNumber: "",
                                  waitingStatus: false,
                                );
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffD22021),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        MaterialButton(
                          color: Color(0xf8d8f8ee),
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          focusElevation: 0.0,
                          disabledElevation: 0.0,
                          hoverElevation: 0.0,
                          height: 32.h,
                          minWidth: 111.w,
                          onPressed: () {
                            context.read<AcceptDeclineCubit>()
                              ..accept(
                                patientID: 9,
                                phoneNumber: "",
                                waitingStatus: true,
                              );
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff0EB475),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.h),
          ],
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
