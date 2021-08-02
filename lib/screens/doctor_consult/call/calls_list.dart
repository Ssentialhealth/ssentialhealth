import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'call_page.dart';
import 'get_credit_page.dart';

class CallsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<CallsList> {
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
                      onPressed: () {},
                    ),

                    //call
                    IconButton(
                      icon: Icon(
                        MdiIcons.phone,
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
                            ),
                          ),
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
