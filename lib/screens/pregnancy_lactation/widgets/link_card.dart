import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/pregnancy_lactation_resources_model.dart';
import 'package:pocket_health/screens/mental_health/mental_health_resources_model.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/pregnancy_lactation_resources.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'copy_to_clipboard.dart';

class LinkCard extends StatelessWidget {
  final MentalHealthResourcesModel mentalLinkResource;
  final PregnancyLactationResourcesModel pregLinkResource;
  final String from;
  const LinkCard({Key key, this.mentalLinkResource, this.pregLinkResource, this.from}) : super(key: key);

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
                      from == "preg" ? pregLinkResource.resourceInfo : mentalLinkResource.resourceInfo,
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
                      from == "preg" ? pregLinkResource.resourceInfo : mentalLinkResource.resourceInfo,
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
                decoration: BoxDecoration(
                  color: accentColorLight,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            from == "preg" ? pregLinkResource.information.split("http").first : mentalLinkResource.information.split("http").first,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              from == "preg"
                                  ? _launchURL("http" + pregLinkResource.information.split('http').last)
                                  : _launchURL("http" + mentalLinkResource.information.split('http').last);
                            },
                            child: Text(
                              from == "preg"
                                  ? "http" + pregLinkResource.information.split("http").last
                                  : "http" + mentalLinkResource.information.split('http').last,
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
                    CopyToClipboard(
                      toCopy: from == "preg"
                          ? "http" + pregLinkResource.information.split('http').last
                          : "http" + mentalLinkResource.information.split('http').last,
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
