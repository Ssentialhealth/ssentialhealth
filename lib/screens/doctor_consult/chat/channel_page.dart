import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/screens/doctor_consult/call/call_page.dart';
import 'package:pocket_health/screens/doctor_consult/call/get_credit_page.dart';
import 'package:pocket_health/screens/doctor_consult/chat/thread_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_details_page.dart';
import 'channel_info.dart';

class ChannelPage extends StatefulWidget {
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
	Message _quotedMessage;
  String durationVal = "5 minutes";

  //get attachments
  // Future<List<Attachment>> getAttachments() async {
  // Future<List<Attachment>> getAttachments() async {
  //   final channelState = await StreamChannel.of(context).channel.query(
  //     options: {
  //       "filter": {
  //         "message_filter_conditions": {
  //           "attachments": {
  //             "\$in": [StreamChannel.of(context).channel]
  //           }
  //         },
  //       },
  //     },
  //     messagesPagination: PaginationParams(limit: 10),
  //   ).onError((error, stackTrace) {
  //     print(error.toString());
  //     return null;
  //   });
  //
  //   final messagesWithAttachments = channelState?.messages;
  //   List<Attachment> attachments = [];
  //   messagesWithAttachments?.forEach((element) {
  //     print(" -------------------------id");
  //     print(element.id);
  //     attachments = element.attachments;
  //   });
  //
  //   return messagesWithAttachments?.length == attachments?.length ? attachments : null;
  // }

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).user;
    final channel = StreamChannel.of(context).channel;
    final channelID = StreamChannel.of(context).channel.id;
    final userID = StreamChat.of(context).user.id;
    final List<Message> allMessages = channel.state.messages;
    bool doctorsView = user.extraData['userCategory'] != "individual" && user.extraData['userCategory'] != null;

    print('channel page user  ---------------------------  $userID');

    return Scaffold(
      //header
      appBar: ChannelHeader(
        subtitle: SizedBox.shrink(),
        showConnectionStateTile: true,
        showTypingIndicator: true,
        onTitleTap: () {},
        title: Container(
          width: 324.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //avi
              UserAvatar(
                constraints: BoxConstraints(
                  minWidth: 36.w,
                  maxHeight: 36.w,
                  maxWidth: 36.w,
                  minHeight: 36.w,
                ),
                user: User(id: channel.id),
              ),

              SizedBox(width: 8.w),
              //details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ChannelName(
                    textStyle: StreamChatTheme.of(context).channelTheme.channelHeaderTheme.title,
                  ),
                  SizedBox(height: 2.h),
                  ChannelInfo(
                    showTypingIndicator: true,
                    channel: StreamChannel.of(context).channel,
                    textStyle: StreamChatTheme.of(context).channelTheme.channelHeaderTheme.subtitle,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
	        // video call
          IconButton(
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
                            "docDetail.surname",
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
                            'KES ${durationVal.split(" ").first}',
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
                          BlocConsumer<CallBalanceCubit, CallBalanceState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is CallBalanceFetchSuccess) {
                                // final amount = double.parse(state.callBalanceModel.amount.split(".").first);
                                final balance = double.parse(state.callBalanceModel?.amount?.split(".")?.first);
                                return BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, loginState) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (loginState is LoginLoaded) print("-------------------USERID${loginState.loginModel.user.userID}");
                                          // await for camera and mic permissions before pu-shing video page
                                          await Permission.camera.request();
                                          await Permission.microphone.request();
                                          // push video page with given channel name
                                          balance != null
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      print("try navigate to call");
                                                      return CallPage(
                                                        callDuration: int.parse(durationVal.split(" ").first),
                                                        channelName: 'testchannel1',
                                                        role: ClientRole.Broadcaster,
                                                        mutedAudio: false,
                                                        mutedVideo: false,
                                                        userID: loginState is LoginLoaded ? loginState.loginModel.user.userID : null,
                                                        docID: 12,
                                                        callBalanceAmount: balance,
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      print("try navigate to credit");
                                                      return GetCreditPage();
                                                    },
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
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
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
            icon: Icon(MdiIcons.video),
          ),

          //audio call
          IconButton(
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
	                          "docDetail.surname",
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
	                          'KES ${durationVal.split(" ").first}',
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
                          BlocConsumer<CallBalanceCubit, CallBalanceState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is CallBalanceFetchSuccess) {
                                // final amount = double.parse(state.callBalanceModel.amount.split(".").first);
                                final balance = double.parse(state.callBalanceModel?.amount?.split(".")?.first);
                                return BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, loginState) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (loginState is LoginLoaded) print("-------------------USERID${loginState.loginModel.user.userID}");
                                          // await for camera and mic permissions before pu-shing video page
                                          await Permission.camera.request();
                                          await Permission.microphone.request();
                                          // push video page with given channel name
                                          balance != null
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      print("try navigate to call");
                                                      return CallPage(
                                                        callDuration: int.parse(durationVal.split(" ").first),
                                                        channelName: 'testchannel1',
                                                        role: ClientRole.Broadcaster,
                                                        mutedAudio: false,
                                                        mutedVideo: true,
                                                        userID: loginState is LoginLoaded ? loginState.loginModel.user.userID : null,
                                                        docID: 12,
                                                        callBalanceAmount: balance,
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      print("try navigate to credit");
                                                      return GetCreditPage();
                                                    },
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
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
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
              // await Permission.camera.request();
              // await Permission.microphone.request();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CallPage(
              //       channelName: 'testchannel1',
              //       role: ClientRole.Broadcaster,
              //       mutedAudio: false,
              //       mutedVideo: true,
              //     ),
              //   ),
              // );
            },
            icon: Icon(Icons.call),
          ),
	        // more details page
          IconButton(
            onPressed: () async {
              final channelState = await channel.query(
                options: {
                  "filter": {
                    "message_filter_conditions": {
                      "attachments": {
                        "\$in": [userID]
                      }
                    },
                  },
                },
                messagesPagination: PaginationParams(limit: 10),
              ).onError((error, stackTrace) {
                print(error.toString());
                return null;
              });

              final messagesWithAttachments = channelState?.messages;
              List<String> attachments = [];
              messagesWithAttachments?.forEach((element) {
                print(" -------------------------id");
                print(element.id);

                element.attachments.where((e) => e.imageUrl != null).forEach((element) {
                  final imageUrl = element.imageUrl;
                  attachments.add(imageUrl);
                });

                return attachments;
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => StreamChannel(
                    channel: channel,
                    child: ChannelDetailsPage(
                      attachments: attachments,
                      isMuted: channel.isMuted,
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
        showBackButton: true,
      ),
      //messages
      body: Column(
        children: [
          //messages view
          Expanded(
            child: MessageListView(
              showScrollToBottom: false,
              onMessageSwiped: (message) {
                setState(() {
                  _quotedMessage = message;
                });
              },
              threadBuilder: (_, parentMessage) => ThreadPage(
                parent: parentMessage,
              ),
            ),
          ),

          //doctors input
          doctorsView
              ? (allMessages.where((element) => element.user.id == userID).toList().length > 0) == true
                  //invite accepted // continue chatting
                  ? MessageInput(
                      onMessageSent: (message) async {},
                      quotedMessage: _quotedMessage,
                      onQuotedMessageCleared: () {
                        setState(() => _quotedMessage = null);
                      },
                    )
                  //invite pending
                  : ColoredBox(
                      color: accentColorLight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //reject invite
                          RawMaterialButton(
                            elevation: 0.0,
                            highlightElevation: 0.0,
                            highlightColor: Colors.transparent,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                            splashColor: Color(0xffeecccc),
                            onPressed: () async {
                              await channel.rejectInvite();
                              await channel.delete();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                          //accept invite
                          RawMaterialButton(
                            elevation: 0.0,
                            highlightElevation: 0.0,
                            highlightColor: Colors.transparent,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                            splashColor: Color(0xffcae9ca),
                            onPressed: () async {
                              await channel.acceptInvite(
                                Message(
                                  text: channelID + ' has accepted your invite. You can continue chatting',
                                ),
                              );
                              setState(() {});
                            },
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    )

              // users input
              : (allMessages.where((element) => element.user.id != userID).toList().length > 0)
                  //invite accepted // continue chatting
                  ? MessageInput(
                      onMessageSent: (message) async {},
                      quotedMessage: _quotedMessage,
                      onQuotedMessageCleared: () {
                        setState(() => _quotedMessage = null);
                      },
                    )
                  //invite pending
                  : ((allMessages.where((element) => element.user.id != userID).toList().length > 0) == false)
                      ? (allMessages.length >= 2)
                          //waiting for response / disable spamming invites
                          ? MessageInput(
                              onMessageSent: (message) async {},
                              quotedMessage: _quotedMessage,
                              onQuotedMessageCleared: () {
                                setState(() => _quotedMessage = null);
                              },
                            )
                          //invite doc
                          : MessageInput(
                              onMessageSent: (message) async {
                                await channel.inviteMembers(
                                  [channelID],
                                  Message(
                                    text: userID + ' wants to invite you to a chat. Accept or Reject',
                                  ),
                                );
                              },
                              quotedMessage: _quotedMessage,
                              onQuotedMessageCleared: () {
                                setState(() => _quotedMessage = null);
                              },
                            )
                      : null,
        ],
      ),
    );
  }
}
