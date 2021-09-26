import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/facility_reviews/facility_reviews_cubit.dart';
import 'package:pocket_health/bloc/post_facility_review/post_facility_review_cubit.dart';
import 'package:pocket_health/utils/constants.dart';

class WriteFacilityReviewDialog extends StatefulWidget {
  @override
  _WriteFacilityReviewDialogState createState() => _WriteFacilityReviewDialogState();
}

class _WriteFacilityReviewDialogState extends State<WriteFacilityReviewDialog> {
  double ratingVal;
  double timelyVal;
  double affordabilityVal;
  double customerCareVal;
  double serviceProductsAvailabilityVal;
  String reviewTextVal;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //user
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //user avi
                CircleAvatar(
                  radius: 22.w,
                  backgroundImage: AssetImage("assets/images/progile.jpeg"),
                ),
                SizedBox(width: 8.w),
                //name & posting
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        'Dr.Darren Elder',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff242424),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Posting public',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6A6969),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 15.h),

            Text(
              'Service Products Availability',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ), //rating bar
            SizedBox(height: 4),

            RatingBar(
              itemCount: 5,
              itemSize: 20.w,
              direction: Axis.horizontal,
              allowHalfRating: true,
              glow: false,
              updateOnDrag: true,
              initialRating: 0,
              minRating: 0,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
              maxRating: 5,
              unratedColor: Colors.orange.shade100,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.orange,
                ),
                half: Icon(
                  Icons.star_half_outlined,
                  size: 20.w,
                  color: Colors.orange,
                ),
                empty: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.grey[400],
                ),
              ),
              onRatingUpdate: (double val) {
                setState(() {
                  serviceProductsAvailabilityVal = val;
                });
              },
            ),
            SizedBox(height: 4),

            Text(
              'Timely',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4),

            RatingBar(
              itemCount: 5,
              itemSize: 20.w,
              direction: Axis.horizontal,
              allowHalfRating: true,
              glow: false,
              updateOnDrag: true,
              initialRating: 0,
              minRating: 0,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
              maxRating: 5,
              unratedColor: Colors.orange.shade100,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.orange,
                ),
                half: Icon(
                  Icons.star_half_outlined,
                  size: 20.w,
                  color: Colors.orange,
                ),
                empty: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.grey[400],
                ),
              ),
              onRatingUpdate: (double val) {
                setState(() {
                  timelyVal = val;
                });
              },
            ),
            SizedBox(height: 4),
            Text(
              'Customer Care',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4),

            RatingBar(
              itemCount: 5,
              itemSize: 20.w,
              direction: Axis.horizontal,
              allowHalfRating: true,
              glow: false,
              updateOnDrag: true,
              initialRating: 0,
              minRating: 0,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
              maxRating: 5,
              unratedColor: Colors.orange.shade100,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.orange,
                ),
                half: Icon(
                  Icons.star_half_outlined,
                  size: 20.w,
                  color: Colors.orange,
                ),
                empty: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.grey[400],
                ),
              ),
              onRatingUpdate: (double val) {
                setState(() {
                  customerCareVal = val;
                });
              },
            ),
            SizedBox(height: 4),

            Text(
              'Affordability',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4),

            RatingBar(
              itemCount: 5,
              itemSize: 20.w,
              direction: Axis.horizontal,
              allowHalfRating: true,
              glow: false,
              updateOnDrag: true,
              initialRating: 0,
              minRating: 0,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
              maxRating: 5,
              unratedColor: Colors.orange.shade100,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.orange,
                ),
                half: Icon(
                  Icons.star_half_outlined,
                  size: 20.w,
                  color: Colors.orange,
                ),
                empty: Icon(
                  Icons.star,
                  size: 20.w,
                  color: Colors.grey[400],
                ),
              ),
              onRatingUpdate: (double val) {
                setState(() {
                  affordabilityVal = val;
                });
              },
            ),

            SizedBox(height: 15.h),
            TextField(
              style: TextStyle(
                color: textBlack,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              minLines: 6,
              maxLines: 6,
              onChanged: (val) {
                setState(() {
                  reviewTextVal = val;
                });
              },
              maxLength: 300,
              maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
              cursorColor: accentColorDark,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                hintText: 'Write your review',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
                counterStyle: TextStyle(
                  color: textBlack,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 0.75.w,
                    color: accentColorDark,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 1.5.w,
                    color: accentColorDark,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //cancel
                Spacer(),
                TextButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: accentColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(0, 0)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    )),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                SizedBox(width: 8.w),
                //post
                BlocConsumer<PostFacilityReviewCubit, PostFacilityReviewState>(
                  listener: (context, state) {
                    if (state is PostReviewDone) {
                      context.read<FacilityReviewsCubit>()..loadFacilityReviews();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is PostReviewsLoading) {
                      return TextButton(
                        child: SizedBox(
                          height: 17.w,
                          width: 17.w,
                          child: CircularProgressIndicator(
                            color: Colors.tealAccent,
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
                        onPressed: () {},
                      );
                    }
                    if (state is PostReviewsFailure) {}
                    if (state is PostReviewInitial) {
                      return TextButton(
                        child: Text(
                          'POST',
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
                        onPressed: () async {
                          if (affordabilityVal != null &&
                              timelyVal != null &&
                              serviceProductsAvailabilityVal != null &&
                              customerCareVal != null &&
                              reviewTextVal != null) {
                            final avgRating =
                                ((affordabilityVal.toDouble() + customerCareVal.toDouble() + serviceProductsAvailabilityVal.toDouble() + timelyVal.toDouble()) /
                                        4.0)
                                    .toDouble();
                            context.read<PostFacilityReviewCubit>()
                              ..postReview(
                                user: 5,
                                rating: avgRating,
                                comments: reviewTextVal,
                                facility: 1,
                                affordability: affordabilityVal.toDouble(),
                                customerCare: customerCareVal.toDouble(),
                                serviceProductsAvailability: serviceProductsAvailabilityVal.toDouble(),
                                timely: timelyVal.toDouble(),
                              );
                          }
                        },
                      );
                    }
                    if (state is PostReviewDone) {
                      return TextButton(
                        child: Icon(
                          Icons.check,
                          color: Colors.tealAccent,
                          size: 21.w,
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
                        onPressed: () {},
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
