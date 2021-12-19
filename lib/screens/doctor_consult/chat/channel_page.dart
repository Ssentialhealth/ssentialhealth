import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:http/http.dart" as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/screens/doctor_consult/call/init_call_dialog.dart';
import 'package:pocket_health/screens/doctor_consult/chat/thread_page.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_details_page.dart';
import 'channel_info.dart';

class ChannelPage extends StatefulWidget {
  final String referral;

  const ChannelPage({
    Key key,
    this.referral,
  }) : super(key: key);
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  Message _quotedMessage;
  String durationVal = "5 minutes";

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).user;
    final channel = StreamChannel.of(context).channel;
    final channelID = StreamChannel.of(context).channel.id;
    final userID = StreamChat.of(context).user.id;
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
                showOnlineStatus: true,
                user: User(id: channel.id),
              ),

              SizedBox(width: 8.w),
              //details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 138.w,
                    child: ChannelName(
                      textStyle: StreamChatTheme.of(context).channelTheme.channelHeaderTheme.title,
                    ),
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
        actions: doctorsView
            ? [
                // more details page
                IconButton(
                  onPressed: () async {
                    final streamProfile = await channel
                        .queryMembers(filter: {}).then((value) => value.members.firstWhere((e) => e.userId != StreamChat.of(context).user.id).user);

                    final userCategory = streamProfile.extraData['userCategory'];
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => StreamChannel(
                          channel: channel,
                          child: ChannelDetailsPage(
                            userCategory: userCategory,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.info_outline),
                ),
              ]
            : [
                // video call
                IconButton(
                  onPressed: () async {
                    final streamProfile = await channel
                        .queryMembers(filter: {}).then((value) => value.members.firstWhere((e) => e.userId != StreamChat.of(context).user.id).user);
                    final apiService = ApiService(http.Client());
                    final hourlyRate = await apiService.fetchFacilityHourlyRate();
                    final facilityHourlyRate = int.parse(hourlyRate.split(".").first);

                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        final isDoc = streamProfile.extraData["userCategory"] == "health practitioner";
                        final isAgent = streamProfile.extraData["userCategory"] == "insurance agent";
                        return StreamChannel(
                          channel: channel,
                          child: InitCallDialog(
                            from: isAgent
                                ? "agent-chat"
                                : isDoc
                                    ? "doc-chat"
                                    : 'facility-chat',
                            videoMuted: false,
                            facilityHourlyRate: isDoc ? 0 : facilityHourlyRate,
                            isVerified: streamProfile.extraData["isVerified"] == "true" ? true : false,
                            streamProfile: streamProfile,
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
                    final streamProfile = await channel
                        .queryMembers(filter: {}).then((value) => value.members.firstWhere((e) => e.userId != StreamChat.of(context).user.id).user);
                    final apiService = ApiService(http.Client());
                    final hourlyRate = await apiService.fetchFacilityHourlyRate();
                    final facilityHourlyRate = int.parse(hourlyRate.split(".").first);

                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        final isDoc = streamProfile.extraData["userCategory"] == "health practitioner";
                        final isAgent = streamProfile.extraData["userCategory"] == "insurance agent";

                        return StreamChannel(
                          channel: channel,
                          child: InitCallDialog(
                            from: isAgent
                                ? "agent-chat"
                                : isDoc
                                    ? "doc-chat"
                                    : 'facility-chat',
                            videoMuted: true,
                            facilityHourlyRate: isDoc ? 0 : facilityHourlyRate,
                            isVerified: streamProfile.extraData["isVerified"] == "true" ? true : false,
                            streamProfile: streamProfile,
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.call),
                ),

                // more details page
                IconButton(
                  onPressed: () async {
                    final streamProfile = await channel
                        .queryMembers(filter: {}).then((value) => value.members.firstWhere((e) => e.userId != StreamChat.of(context).user.id).user);

                    final userCategory = streamProfile.extraData['userCategory'];
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => StreamChannel(
                          channel: channel,
                          child: ChannelDetailsPage(
                            userCategory: userCategory,
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

          MessageInput(
            onMessageSent: (message) async {},
            quotedMessage: _quotedMessage,
            onQuotedMessageCleared: () {
              setState(() => _quotedMessage = null);
            },
          ),
        ],
      ),
    );
  }
}
