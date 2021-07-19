import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/filter_reviews/filter_reviews_cubit.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/utils/constants.dart';

class SortReviewsRow extends StatelessWidget {
  final List<ReviewModel> toSort;

  const SortReviewsRow({Key key, this.toSort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterReviewsCubit, FilterReviewsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //recent
              GestureDetector(
                onTap: () {
                  context.read<FilterReviewsCubit>()..loadRecentlyRated();
                },
                child: Visibility(
                  replacement: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.w),
                      border: Border.all(
                        color: Color(0xffC6C6C6),
                        width: 1.5.w,
                      ),
                    ),
                    height: 34.h,
                    child: Center(
                      child: Text(
                        'Recent',
                        style: TextStyle(
                          color: Color(0xff5C5C5C),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  visible: state is RecentlyRatedLoaded,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: accentColorLight,
                      borderRadius: BorderRadius.circular(100.w),
                      border: Border.all(
                        color: accentColorDark,
                        width: 1.5.w,
                      ),
                    ),
                    height: 34.h,
                    child: Center(
                      child: Text(
                        'Recent',
                        style: TextStyle(
                          color: accentColorDark,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              //highest
              GestureDetector(
                onTap: () {
                  context.read<FilterReviewsCubit>()..loadHighestRated(toSort: toSort);
                },
                child: Visibility(
                  visible: state is HighestRatedLoaded,
                  replacement: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.w),
                      border: Border.all(
                        color: Color(0xffC6C6C6),
                        width: 1.5.w,
                      ),
                    ),
                    height: 34.h,
                    child: Center(
                      child: Text(
                        'Highest Rated',
                        style: TextStyle(
                          color: Color(0xff5C5C5C),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: accentColorLight,
                      borderRadius: BorderRadius.circular(100.w),
                      border: Border.all(
                        color: accentColorDark,
                        width: 1.5.w,
                      ),
                    ),
                    height: 34.h,
                    child: Center(
                      child: Text(
                        'Highest Rated',
                        style: TextStyle(
                          color: accentColorDark,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),

              //lowest
              GestureDetector(
                onTap: () {
                  context.read<FilterReviewsCubit>()..loadLowestRated(toSort: toSort);
                },
                child: Visibility(
                  visible: state is LowestRatedLoaded,
                  replacement: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.w),
                      border: Border.all(
                        color: Color(0xffC6C6C6),
                        width: 1.5.w,
                      ),
                    ),
                    height: 34.h,
                    child: Center(
                      child: Text(
                        'Lowest Rated',
                        style: TextStyle(
                          color: Color(0xff5C5C5C),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                    decoration: BoxDecoration(
                      color: accentColorLight,
                      borderRadius: BorderRadius.circular(100.w),
                      border: Border.all(
                        color: accentColorDark,
                        width: 1.5.w,
                      ),
                    ),
                    height: 34.h,
                    child: Center(
                      child: Text(
                        'Lowest Rated',
                        style: TextStyle(
                          color: accentColorDark,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
