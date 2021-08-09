import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/utils/constants.dart';

import 'call_page.dart';
import 'get_credit_page.dart';

class CallsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<CallsList> {
  String durationVal = "5 minutes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              title: Text(
                'Get Credit',
                style: TextStyle(),
              ),
              leading: CircleAvatar(
                radius: 24.w,
                backgroundImage: AssetImage("assets/images/progile.jpeg"),
              ),
              subtitle: Text(
                'Now',
                style: TextStyle(),
              ),
              trailing: RawMaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: 100,
                ),
                elevation: 0.0,
                hoverElevation: 0.0,
                fillColor: Colors.orangeAccent,
                shape: StadiumBorder(),
                child: Row(
                  children: [
                    Text(
                      'GET CREDIT',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    Icon(
                      MdiIcons.bitcoin,
                      size: 22.sp,
                      color: Color(0xff242424),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GetCreditPage()),
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                'Dr. Edder',
                style: TextStyle(),
              ),
              leading: CircleAvatar(
                radius: 24.w,
                backgroundImage: AssetImage("assets/images/progile.jpeg"),
              ),
              subtitle: Text(
                'Psychologist',
                style: TextStyle(),
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    //bookmark
                    IconButton(
                      icon: Icon(
                        MdiIcons.videoOutline,
                        size: 22.sp,
                        color: Color(0xff242424),
                      ),
                      onPressed: () async {
                        // await for camera and mic permissions before pu-shing video page
                        await Permission.camera.request();
                        await Permission.microphone.request();
                        // push video page with given channel name
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallPage(
                              channelName: 'testchannel1',
                              role: ClientRole.Broadcaster,
                              mutedAudio: false,
                              mutedVideo: true,
                            ),
                          ),
                        );
                      },
                    ),

                    //call
                    IconButton(
                      icon: Icon(
                        MdiIcons.phone,
                        size: 22.sp,
                        color: Color(0xff242424),
                      ),
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
                              child: Container(
                                width: 1.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 15.h),

                                    //doc name
                                    Text(
                                      'Call Doctor Eder',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),

                                    Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                                    SizedBox(height: 15.h),
                                    Text(
                                      'Estimated Call Cost',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    //cost
                                    Text(
                                      'USD 10',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),

                                    //drop down
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: DropdownButtonFormField(
                                        value: durationVal,
                                        isExpanded: true,
                                        onTap: () {},
                                        onChanged: (val) {
                                          setState(() {
                                            durationVal = val;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24.r,
                                          color: accentColorDark,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: accentColorDark,
                                              width: 1.w,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: accentColorDark,
                                              width: 1.w,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: accentColorDark,
                                              width: 1.w,
                                            ),
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                        ),
                                        elevation: 0,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xff707070),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        dropdownColor: Colors.white,
                                        hint: Text(
                                          'Select Duration',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Color(0xff707070),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        items: ["5 minutes", "10 minutes", "15 minutes"]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    SizedBox(height: 15.h),

                                    //continue
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          // await for camera and mic permissions before pu-shing video page
                                          await Permission.camera.request();
                                          await Permission.microphone.request();
                                          // push video page with given channel name
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CallPage(
                                                callDuration: int.parse(durationVal.split(" ").first),
                                                channelName: 'testchannel1',
                                                role: ClientRole.Broadcaster,
                                                mutedAudio: false,
                                                mutedVideo: false,
                                              ),
                                            ),
                                          );
                                        },
                                        minWidth: 374.w,
                                        elevation: 0.0,
                                        child: Text(
                                          'Continue',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        highlightElevation: 0.0,
                                        focusElevation: 0.0,
                                        disabledElevation: 0.0,
                                        color: Color(0xff1A5864),
                                        height: 40.h,
                                        highlightColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.h),

                                    //show balance
                                    TextButton(
                                      onPressed: () async {
                                        //navigate to get credit
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => GetCreditPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Check Balance',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: accentColorDark,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
