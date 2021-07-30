import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_list.dart';

class InitializeStream extends StatelessWidget {
  final client = StreamChatClient(
    '5ce52vsjkw26',
    logLevel: Level.OFF,
  );

  initialize() async {
    await client.disconnect();
    await client.connectUser(
      User(
        id: 'testdoc6',
      ),
      client.devToken('testdoc6'),
    );
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return StreamChat(client: client, child: ChannelList());
  }
}
