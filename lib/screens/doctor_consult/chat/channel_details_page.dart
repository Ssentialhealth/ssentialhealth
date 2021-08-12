import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/home/home.dart';
import 'package:pocket_health/screens/practitioners/filter_title.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelDetailsPage extends StatefulWidget {
  final bool isMuted;
  final List<String> attachments;

  const ChannelDetailsPage({Key key, this.isMuted, this.attachments}) : super(key: key);

  @override
  _ChannelDetailsPageState createState() => _ChannelDetailsPageState();
}

class _ChannelDetailsPageState extends State<ChannelDetailsPage> {
	bool saveContactVal = false;

  bool newMutedVal;

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;

    return StreamChannel(
      channel: channel,
      child: Scaffold(
        backgroundColor: accentColorLight,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: accentColor,
          title: Text(
            "Chat Details",
            style: appBarStyle,
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //settings
              FilterTitle(filter: "SETTINGS"),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //search channel
              ListTile(
                leading: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                onTap: () {},
                isThreeLine: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                tileColor: Colors.white,
                dense: true,
                title: Text(
                  'Search Conversation',
                  style: listTileTitleStyle,
                ),
              ),
              Divider(height: 0.0, thickness: 0.5, indent: 20.r, endIndent: 20.r, color: Color(0xffB3B3B3)),

              //delete conversation
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.black54,
                ),
                onTap: () {
                  channel.delete();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => Home()),
                    (route) => false,
                  );
                },
                isThreeLine: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                tileColor: Colors.white,
                dense: true,
                title: Text(
                  'Delete Conversation',
                  style: listTileTitleStyle,
                ),
              ),
              Divider(height: 0.0, thickness: 0.5, indent: 20.r, endIndent: 20.r, color: Color(0xffB3B3B3)),

              //schedule a call
              ListTile(
                leading: Icon(
                  Icons.notification_add,
                  color: Colors.black54,
                ),
                onTap: () {},
                isThreeLine: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                tileColor: Colors.white,
                dense: true,
                title: Text(
                  'Schedule a call',
                  style: listTileTitleStyle,
                ),
              ),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //notifications
              FilterTitle(filter: "NOTIFICATIONS"),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //mute
              SwitchListTile(
                value: newMutedVal == null ? widget.isMuted : newMutedVal,
                isThreeLine: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                dense: true,
                onChanged: (val) {
                  setState(() {
                    newMutedVal = val;
                  });

                  if (newMutedVal != null) {
                    if (newMutedVal == true) {
                      channel.mute();
                    }
                    if (newMutedVal == false) {
                      channel.unmute();
                    }
                  }
                },
                tileColor: Colors.white,
                title: Text(
                  'Mute Notifications',
                  style: listTileTitleStyle,
                ),
              ),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //gallery
              Padding(
                padding: EdgeInsets.only(left: 20.r, top: 12.r, bottom: 12.r, right: 20.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'GALLERY',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Show More',
                      style: TextStyle(
                        color: accentColorDark,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              widget.attachments.length == 0
                  //empty gallery
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
                      child: Container(
                        width: 374.w,
                        height: 150.h,
                        decoration: BoxDecoration(color: accentColorDark, borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Your Gallery is empty',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  'Photos, files, and web links shared in this chat will appear here.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.w),
                      child: Container(
                        height: 150.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.attachments.length,
                          shrinkWrap: true,
                          itemBuilder: (context, s) {
                            final attachment = widget.attachments[s];
                            print("---------");
                            print(attachment);
                            return Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                ),
                                child: Image(
                                  height: 120.h,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(attachment),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //save contact
              SwitchListTile(
                value: saveContactVal,
                isThreeLine: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                dense: true,
                onChanged: (val) async {
                  setState(() {
                    saveContactVal = val;
                  });

                  if (saveContactVal) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var list = prefs.getStringList("saved");
                    list.add("${channel.id}");
                    await prefs.setStringList('saved', list);
                  }
                  if (!saveContactVal) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var list = prefs.getStringList("saved");
                    list.remove("${channel.id}");
                    await prefs.setStringList('saved', list);
                  }
                },
                tileColor: Colors.white,
                title: Text(
                  'Save Contact',
                  style: listTileTitleStyle,
                ),
              ),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //block contact
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 0.0,
                  fillColor: accentColorLight,
                  child: Text(
                    'Block Contact',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
