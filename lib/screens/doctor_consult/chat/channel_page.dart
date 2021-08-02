import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/screens/doctor_consult/call/call_page.dart';
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
          //video call
          IconButton(
            onPressed: () async {
              await Permission.camera.request();
              await Permission.microphone.request();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(
                    channelName: 'testchannel1',
                    role: ClientRole.Broadcaster,
                    mutedAudio: false,
                    mutedVideo: false,
                  ),
                ),
              );
            },
            icon: Icon(MdiIcons.video),
          ),

          //audio call
          IconButton(
            onPressed: () async {
              await Permission.camera.request();
              await Permission.microphone.request();
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
            icon: Icon(Icons.call),
          ),
          //more details page
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ChannelDetailsPage(),
                ),
              );
            },
            icon: Icon(Icons.more_vert),
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
