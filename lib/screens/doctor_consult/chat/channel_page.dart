import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/doctor_consult/chat/thread_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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
      appBar: ChannelHeader(),
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
