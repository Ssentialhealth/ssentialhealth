import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/copy_to_clipboard.dart';
import 'package:pocket_health/screens/wellness/pdf_view_page.dart';
import 'package:pocket_health/utils/constants.dart';

class TabContent extends StatelessWidget {
  final String overview;
  final int reference;
  const TabContent({
    Key key,
    this.overview,
    this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //overview
          MarkdownBody(
            data: overview,
            shrinkWrap: true,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          //pdf
          Consumer(
            builder: (context, ScopedReader watch, child) {
              final linksAsyncVal = watch(linksModelProvider);
              return linksAsyncVal.when(
                data: (links) {
                  final link = links.singleWhere((element) => element.id == reference);
                  return Container(
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
                  );
                },
                loading: () => Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: accentColorLight,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  height: 80.h,
                  width: 350.w,
                  child: Container(
                    height: 20.h,
                    width: 20.h,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (err, stack) {
                  print('--------|stack|--------|value -> ${stack.toString()}');
                  return Text(
                    err.toString(),
                    style: TextStyle(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
