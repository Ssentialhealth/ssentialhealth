import 'dart:io';
import 'dart:io' as io;

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/screens/wellness/pdf_view_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SigningDocumentsPage extends StatefulWidget {
  @override
  _SigningDocumentsPageState createState() => _SigningDocumentsPageState();
}

class _SigningDocumentsPageState extends State<SigningDocumentsPage> {
  List<FileSystemEntity> files = [];
  Future<void> getFiles() async {
    await Permission.storage.request();
    final path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    setState(() {
      files = io.Directory("$path").listSync();
    });
    print(files);
  }

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Sign viewed documents',
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: files.map(
            (e) {
              final fileName = e.path.split("Download/").last.split(".").first;
              print('--------|fileName|--------|value -> ${fileName.toString()}');
              return Consumer(
                builder: (context, ScopedReader watch, child) {
                  final linksAsyncVal = watch(linksModelProvider);
                  return linksAsyncVal.when(
                    data: (data) {
                      final links = data.where((e) => e.linkName.toLowerCase().contains("rate") || e.linkName.toLowerCase().contains("policy")).toList();
                      final viewedLinks = links.where((element) => element.linkName == fileName).toList();
                      if (viewedLinks.length == 0) return SizedBox.shrink();

                      return ListView.builder(
                        itemCount: viewedLinks.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final link = viewedLinks[index];
                          return Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Container(
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
                                                builder: (context) => PdfViewPage(
                                                  pdf: link.resourceLink,
                                                  pdfTitle: link.linkName,
                                                ),
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
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
                                                child: Container(
                                                  height: 250,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(16.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            'Agree to sign this document?',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w600,
                                                              color: accentColorDark,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'You will be redirected to sejda.com where you will:\n\n  • Upload the document\n  • Type/draw you signature\n  • Sign the document',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w500,
                                                            color: textBlack,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            //cancel
                                                            Spacer(),
                                                            TextButton(
                                                              child: Text(
                                                                'BACK',
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
                                                            TextButton(
                                                              child: Text(
                                                                'AGREE',
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
                                                                _launchURL("https://www.sejda.com/sign-pdf");
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(MdiIcons.pen),
                                      ),
                                    ],
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
                      return Center(
                        child: Text(
                          'Error occurred while fetching documents. Please try again',
                          style: TextStyle(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

void _launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
