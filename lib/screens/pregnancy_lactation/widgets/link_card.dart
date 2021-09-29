import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'copy_to_clipboard.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({Key key}) : super(key: key);

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
                      "Central information about Pregnancy & Lactation conditions, health, quizzes etc",
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
                      "Central information about Pregnancy & Lactation conditions, health, quizzes etc",
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
            Padding(
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
                            "rule.descriptisssssssssssssssssssssssssssssssssssssssssssssssssssssssssssson",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              _launchURL("https://example.com");
                            },
                            child: Text(
                              "https://example.com/",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CopyToClipboard(toCopy: "https://example.com"),
                  ],
                ),
              ),
            ),
            Divider(height: 2.h, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}

void _launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
