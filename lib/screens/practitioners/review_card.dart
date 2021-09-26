import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/utils/constants.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
      margin: EdgeInsets.only(bottom: 15.w, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: Color(0xC000000),
            blurRadius: 4.w,
            spreadRadius: 2.w,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //avi
          CircleAvatar(
            radius: 15.w,
            backgroundImage: AssetImage("assets/images/progile.jpeg"),
          ),

          SizedBox(width: 15.w),

          //details
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //name
              Text(
                review.user.toString(),
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Color(0xff181818),
                ),
              ),

              SizedBox(height: 4.w),

              //rating bar / time ago
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 13.w,
                    direction: Axis.horizontal,
                    rating: review.rating,
                    unratedColor: Colors.orange.shade100,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        size: 13.w,
                        color: Colors.orange,
                      );
                    },
                  ),
                  Text(
                    '  2 weeks ago',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6A6969),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.w),

              //text
              SizedBox(
                width: 280.w,
                child: Text(
                  review.comment,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color(0xff6A6969),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 7.w),

          //ctx menu
          Icon(
            Icons.more_vert,
            size: 20.w,
            color: textBlack,
          ),
        ],
      ),
    );
  }
}
