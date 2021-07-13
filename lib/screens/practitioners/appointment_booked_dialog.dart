import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentBookedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
      child: Container(
        width: 1.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.w),
              height: 130.h,
              child: Image(
                image: AssetImage('assets/images/undraw_happy_announcement_ac67.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.w),
              child: Text(
                "Appointment booked, provider will confirm appointment. Contact provider if no confirmation received",
                maxLines: 3,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6A6969),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0.w),
              child: TextButton(
                child: Text(
                  'Back to Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.w),
                    side: BorderSide(
                      color: Color(0xff1A5864),
                      width: 1.w,
                    ),
                  )),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
