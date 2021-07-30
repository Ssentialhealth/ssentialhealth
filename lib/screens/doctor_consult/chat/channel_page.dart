import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/screens/doctor_consult/chat/thread_page.dart';
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
    print('page channel');
    print('page user');
    print(user.id);
    print(channel.id);
    return StreamChat(
      client: context.read<InitializeStreamChatCubit>().client,
      child: Scaffold(
        appBar: ChannelHeader(),
        body: Column(
          children: [
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
              onMessageSent: (message) async {
                await channel.acceptInvite(Message(text: user.id + 'has accepted your invite. you can continue chatting'));
              },
              quotedMessage: _quotedMessage,
              onQuotedMessageCleared: () {
                setState(() => _quotedMessage = null);
              },
            ),
          ],
        ),
      ),
    );
  }
}
