import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/copy_to_clipboard.dart';
import 'package:pocket_health/screens/wellness/pdf_view_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceCard extends StatelessWidget {
  final LinkModel link;
  const ResourceCard({Key key, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: link.resourceLink.endsWith(".pdf")
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: accentColorLight,
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 306.w,
                        child: Text(
                          link.linkName,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Icon(
                        MdiIcons.adobeAcrobat,
                        color: Colors.red,
                        size: 16.w,
                      ),
                      Text(
                        "PDF",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewPage(pdf: link.resourceLink),
                              ),
                            );
                          },
                          child: Text(
                            link.resourceLink,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CopyToClipboard(
                        toCopy: link.resourceLink,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: accentColorLight,
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 306.w,
                    child: Text(
                      link.linkName,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(link.resourceLink);
                          },
                          child: Text(
                            link.resourceLink,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CopyToClipboard(
                        toCopy: link.resourceLink,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

void _launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
