import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pocket_health/models/doc_bookings.dart';
import 'package:pocket_health/utils/constants.dart';

import 'booking_card.dart';

class BookingsListView extends StatelessWidget {
  final DateTime date;
  final List<DocBookings> docBookings;

  const BookingsListView({Key key, this.date, this.docBookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.MEd().format(date);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28.w),
                topRight: Radius.circular(28.w),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 24.0.w, top: 24.0.w, bottom: 10.w, right: 24.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff081D21),
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    docBookings.length > 1 ? "${docBookings.length} Patients" : "${docBookings.length} Patient",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: accentColorDark,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // bookings
          docBookings.length < 4
              ? Container(
                  height: 1000.h,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: ListView.builder(
                      itemCount: docBookings.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final booking = docBookings[index];
                        return BookingCard(
                          booking: booking,
                          date: date,
                        );
                      },
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: ListView.builder(
                      itemCount: docBookings.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final booking = docBookings[index];

                        return BookingCard(
                          booking: booking,
                          date: date,
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
