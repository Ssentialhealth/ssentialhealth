import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'copy_to_clipboard.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key key}) : super(key: key);

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
                      "Kenya Contacts",
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
                      "Kenya Contacts",
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
                            "Befrienders Association of Kenya",
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
                                  '0722222222',
                                  style: TextStyle(color: textBlack, fontSize: 15.sp),
                                ),
                                Spacer(),
                                CopyToClipboard(toCopy: "072222222"),
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
                                  'johndoe@email.com',
                                  style: TextStyle(color: textBlack, fontSize: 15.sp),
                                ),
                                Spacer(),
                                CopyToClipboard(toCopy: "johndoe@gmail.com"),
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
            Divider(height: 2.h, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}

void _launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
