import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/doctor_consult/chat/search_text_field.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SearchMessagesBuilder extends StatefulWidget {
  @override
  _SearchMessagesBuilderState createState() => _SearchMessagesBuilderState();
}

class _SearchMessagesBuilderState extends State<SearchMessagesBuilder> {
  TextEditingController _controller;
  String query = '';
  String channelID = '';
  bool _isSearchActive = false;
  List<Message> searchedMessages = [];
  Timer _debounce;

  Future<List<Message>> searchMessages(String query) async {
    final channel = StreamChannel.of(context).channel;
    final searchResponse = await channel.query(
      messagesPagination: PaginationParams(limit: 10),
      options: {
        "filter": {
          "message_filter_conditions": {
            "text": {
              "\$eq": query,
            }
          },
        },
      },
    ).onError((error, stackTrace) {
      print(error.toString());
      return null;
    });

    print('searched');
    return searchResponse.messages.where((e) => e.text.contains(query)).toList();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (_, __) => [
            SliverToBoxAdapter(
              child: SearchTextField(
                controller: _controller,
                hintText: 'Search',
                showCloseButton: _isSearchActive,
                onChanged: (val) async {
                  final result = await searchMessages(val);
                  setState(() {
                    searchedMessages = result;
                  });
                },
              ),
            ),
          ],
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Messages',
                      // style: titleText.copyWith(fontSize: 16.0.sp),
                    ),
                    //title
                  ],
                ),
              ),
              ListView.builder(
                itemCount: searchedMessages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final message = searchedMessages[index];
                  FocusScope.of(context).requestFocus(FocusNode());
                  final client = StreamChat.of(context).client;
                  // final channel = client.channel(
                  //   message.
                  //   id: channel.id,
                  // );
                  // if (channel.state == null) {
                  //   await channel.watch();
                  // }

                  return ListTile(
                    dense: true,
                    title: Text(
                      message.user.id,
                      style: TextStyle(),
                    ),
                    subtitle: Text(
                      message.text,
                      style: TextStyle(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
