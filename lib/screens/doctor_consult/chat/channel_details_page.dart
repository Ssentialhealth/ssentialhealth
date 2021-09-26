import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/bloc/saved_facility_contacts/saved_facility_contacts_cubit.dart';
import 'package:pocket_health/screens/doctor_consult/chat/search_messages_builder.dart';
import 'package:pocket_health/screens/home/home.dart';
import 'package:pocket_health/screens/practitioners/filter_title.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelDetailsPage extends StatefulWidget {
  final String userCategory;

  const ChannelDetailsPage({Key key, this.userCategory}) : super(key: key);

  @override
  _ChannelDetailsPageState createState() => _ChannelDetailsPageState();
}

class _ChannelDetailsPageState extends State<ChannelDetailsPage> {
  bool saveContactVal = false;
  bool saveFacilityContactVal = false;
  bool newMutedVal;
  bool isFetching = false;
  List<String> attachments = [];
  String otherUserID;

  void getChannelDetails() async {
    isFetching = true;

    final Channel channel = StreamChannel.of(context).channel;
    final User user = StreamChat.of(context).user;

    //get docID
    otherUserID = await StreamChannel.of(context).channel.queryMembers(filter: {}).then((value) => value.members.firstWhere((e) => e.userId != user.id).userId);

    print('--------|textedDocID|--------|value -> ${otherUserID.toString()}');

    //get attachments
    final channelState = await channel.query(
      options: {
        "filter": {
          "message_filter_conditions": {
            "attachments": {
              "\$in": [user.id]
            }
          },
        },
      },
      messagesPagination: PaginationParams(limit: 10),
    ).onError((error, stackTrace) {
      setState(() {
        isFetching = false;
      });

      print(error.toString());
      return null;
    });

    final messagesWithAttachments = channelState?.messages;
    messagesWithAttachments?.forEach((element) {
      element.attachments.where((e) => e.imageUrl != null).forEach((element) {
        final imageUrl = element.imageUrl;
        attachments.add(imageUrl);
      });
      return attachments;
    });
    setState(() {
      isFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getChannelDetails();
  }

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
          child: isFetching
              ? Center(
                  child: Container(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return StreamChannel(channel: channel, child: SearchMessagesBuilder());
                            },
                          ),
                        );
                      },
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
                      value: newMutedVal == null ? channel.isMuted : newMutedVal,
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

                    attachments.length == 0
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
                                itemCount: attachments.length,
                                shrinkWrap: true,
                                itemBuilder: (context, s) {
                                  final attachment = attachments[s];
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

                    widget.userCategory != "individual"
                        ? BlocBuilder<SavedContactsCubit, SavedContactsState>(
                            builder: (context, state) {
                              if (state is SavedContactsSuccess) {
                                return SwitchListTile(
                                  value: state.savedContacts.contains('${channel.id}') ?? false,
                                  isThreeLine: false,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                  dense: true,
                                  onChanged: (val) async {
                                    setState(() {
                                      saveContactVal = val;
                                    });
                                    context.read<SavedContactsCubit>()..addRemoveContacts(saveContactVal, "$otherUserID");
                                  },
                                  tileColor: Colors.white,
                                  title: Text(
                                    'Save Contact',
                                    style: listTileTitleStyle,
                                  ),
                                );
                              }
                              return SwitchListTile(
                                value: saveContactVal,
                                isThreeLine: false,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                dense: true,
                                onChanged: (val) async {},
                                tileColor: Colors.white,
                                title: Text(
                                  'Save Contact',
                                  style: listTileTitleStyle,
                                ),
                              );
                            },
                          )
                        : BlocBuilder<SavedFacilityContactsCubit, SavedFacilityContactsState>(
                            builder: (context, state) {
                              if (state is SavedFacilityContactsSuccess) {
                                return SwitchListTile(
                                  value: state.savedFacilityContacts.contains('${channel.id}') ?? false,
                                  isThreeLine: false,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                  dense: true,
                                  onChanged: (val) async {
                                    setState(() {
                                      saveFacilityContactVal = val;
                                    });
                                    context.read<SavedFacilityContactsCubit>()..addRemoveContacts(saveFacilityContactVal, "$otherUserID");
                                  },
                                  tileColor: Colors.white,
                                  title: Text(
                                    'Save Contact',
                                    style: listTileTitleStyle,
                                  ),
                                );
                              }
                              return SwitchListTile(
                                value: saveFacilityContactVal,
                                isThreeLine: false,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                dense: true,
                                onChanged: (val) async {},
                                tileColor: Colors.white,
                                title: Text(
                                  'Save Contact',
                                  style: listTileTitleStyle,
                                ),
                              );
                            },
                          ),

                    SizedBox(height: 10.h),

                    // Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                    //block contact
                    // Padding(
                    //   padding: EdgeInsets.only(left: 20.w),
                    //   child: RawMaterialButton(
                    //     onPressed: () {},
                    //     elevation: 0.0,
                    //     fillColor: accentColorLight,
                    //     child: Text(
                    //       'Block Contact',
                    //       style: TextStyle(
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}
