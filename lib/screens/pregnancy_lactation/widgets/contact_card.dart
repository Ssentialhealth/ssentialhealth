import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/pregnancy_lactation_resources_model.dart';
import 'package:pocket_health/screens/mental_health/mental_health_resources_model.dart';
import 'package:pocket_health/utils/constants.dart';

import 'copy_to_clipboard.dart';

class ContactCard extends StatelessWidget {
  final String from;
  const ContactCard({Key key, this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          iconColor: accentColor,
          useInkWell: false,
          tapHeaderToExpand: true,
          hasIcon: false,
          tapBodyToExpand: false,
          tapBodyToCollapse: false,
        ),
        collapsed: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 306,
                    child: Text(
                      "Kenya",
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ExpandableButton(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: accentColorDark,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 2.h, color: Colors.black26),
          ],
        ),
        expanded: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 306.w,
                    child: Text(
                      "Kenya",
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ExpandableButton(
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: accentColorDark,
                    ),
                  ),
                ],
              ),
            ),
            Consumer(builder: (context, ScopedReader watch, child) {
              final pregResourcesAsyncVal = watch(pregnancyLactationResourcesModelFutureProvider);
              final mentalResourcesAsyncVal = watch(mentalHealthResourcesModelFutureProvider);
              if (from == "preg") {
                return pregResourcesAsyncVal.when(
                  data: (resources) {
                    final pregContactResources = resources.where((element) => !element.information.contains("http")).toList();
                    return ListView.builder(
                      itemCount: pregContactResources.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final pregContactResource = pregContactResources[index];
                        return Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.0.w),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            color: accentColorLight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        pregContactResource.information,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),

                                      //number
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.call, size: 18.w, color: accentColorDark),
                                            SizedBox(width: 15.w),
                                            Text(
                                              pregContactResource.phoneNumber,
                                              style: TextStyle(color: textBlack, fontSize: 15.sp),
                                            ),
                                            Spacer(),
                                            CopyToClipboard(toCopy: pregContactResource.phoneNumber),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.mail, size: 18.w, color: accentColorDark),
                                            SizedBox(width: 15.w),
                                            Text(
                                              pregContactResource.email,
                                              style: TextStyle(color: textBlack, fontSize: 15.sp),
                                            ),
                                            Spacer(),
                                            CopyToClipboard(toCopy: pregContactResource.email),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => SizedBox.shrink(),
                  error: (err, stack) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: Text(
                        err,
                        style: TextStyle(),
                      ),
                    );
                  },
                );
              } else {
                return mentalResourcesAsyncVal.when(
                  data: (resources) {
                    final mentalContactResources = resources.where((element) => !element.information.contains("http")).toList();

                    return ListView.builder(
                      itemCount: mentalContactResources.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final mentalContactResource = mentalContactResources[index];
                        return Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.0.w),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            color: accentColorLight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        mentalContactResource.information,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),

                                      //number
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.call, size: 18.w, color: accentColorDark),
                                            SizedBox(width: 15.w),
                                            Text(
                                              mentalContactResource.phoneNumber,
                                              style: TextStyle(color: textBlack, fontSize: 15.sp),
                                            ),
                                            Spacer(),
                                            CopyToClipboard(toCopy: mentalContactResource.phoneNumber),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.mail, size: 18.w, color: accentColorDark),
                                            SizedBox(width: 15.w),
                                            Text(
                                              mentalContactResource.email,
                                              style: TextStyle(color: textBlack, fontSize: 15.sp),
                                            ),
                                            Spacer(),
                                            CopyToClipboard(toCopy: mentalContactResource.email),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => SizedBox.shrink(),
                  error: (err, stack) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: Text(
                        err,
                        style: TextStyle(),
                      ),
                    );
                  },
                );
              }
            }),
            Divider(height: 2.h, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}
