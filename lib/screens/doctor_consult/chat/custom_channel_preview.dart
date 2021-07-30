import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_page.dart';

Widget customChannelPreview(BuildContext context, Channel channel) {
  final lastMessage = channel.state.messages.reversed.firstWhere(
    (message) => message != null && !message.isDeleted,
  );

  final subtitle = lastMessage == null ? 'Nothing Yet' : lastMessage.text;
  // final lastAttachment =  lastMessage == null? "Nothing Yet": lastMessage.attachments;
  final opacity = (channel.state?.unreadCount ?? 0) > 0 ? 1.0 : 0.5;

  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StreamChannel(
            channel: channel,
            child: ChannelPage(),
          ),
        ),
      );
    },
    leading: CircleAvatar(
      backgroundImage: AssetImage("assets/images/progile.jpeg"),
    ),
    title: ChannelName(),
    subtitle: Text(subtitle),
    trailing: channel.state.unreadCount > 0
        ? CircleAvatar(
            radius: 10,
            child: Text(channel.state.unreadCount.toString()),
          )
        : const SizedBox(),
  );
}
