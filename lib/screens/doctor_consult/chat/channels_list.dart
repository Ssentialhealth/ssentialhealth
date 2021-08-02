import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/screens/doctor_consult/chat/search_text_field.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_details_page.dart';
import 'channel_page.dart';

class ChannelsList extends StatefulWidget {
  @override
  _ChannelsListState createState() => _ChannelsListState();
}

class _ChannelsListState extends State<ChannelsList> {
  TextEditingController _controller;

  String _channelQuery = '';

  bool _isSearchActive = false;

  Timer _debounce;

  void _channelQueryListener() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _channelQuery = _controller.text;
          _isSearchActive = _channelQuery.isNotEmpty;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_channelQueryListener);
  }

  @override
  void dispose() {
    _controller?.removeListener(_channelQueryListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(StreamChat.of(context).user.id);

    return WillPopScope(
      onWillPop: () async {
        if (_isSearchActive) {
          _controller.clear();
          setState(() => _isSearchActive = false);
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, isActive) => [
              SliverToBoxAdapter(
                child: SearchTextField(
                  controller: _controller,
                  showCloseButton: _isSearchActive,
                ),
              ),
            ],
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) => FocusScope.of(context).unfocus(),
              child: _isSearchActive
                  ? MessageSearchBloc(
                      child: MessageSearchListView(
                        showErrorTile: true,
                        errorBuilder: (context, er) {
                          return Container(
                            height: 100,
                            color: Colors.red,
                            child: Text(
                              er.toString(),
                              style: TextStyle(),
                            ),
                          );
                        },
                        messageQuery: _channelQuery,
                        filters: {
                          'members': {
                            '\$in': [StreamChat.of(context).user.id],
                          }
                        },
                        sortOptions: [
                          SortOption(
                            'created_at',
                            direction: SortOption.ASC,
                          ),
                        ],
                        pullToRefresh: false,
                        paginationParams: PaginationParams(limit: 20),
                        emptyBuilder: (_) {
                          return LayoutBuilder(
                            builder: (context, viewportConstraints) {
                              return SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: viewportConstraints.maxHeight,
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(24),
                                          child: StreamSvgIcon.search(
                                            size: 96,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'No results...',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        onItemTap: (messageResponse) async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final client = StreamChat.of(context).client;

                          final message = messageResponse.message;
                          final channel = client.channel(
                            messageResponse.channel.type,
                            id: messageResponse.channel.id,
                          );
                          if (channel.state == null) {
                            await channel.watch();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChannelPage();
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : ChannelsBloc(
                      child: ChannelListView(
                        filter: {
                          'members': {
                            '\$in': [StreamChat.of(context).user.id],
                          },
                        },
                        swipeToAction: true,
                        sort: [SortOption('last_message_at')],
                        pagination: PaginationParams(limit: 20),
                        onViewInfoTap: (ca) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => ChannelDetailsPage(),
                            ),
                          );
                        },
                        channelWidget: StreamChat(
                          client: context.read<InitializeStreamChatCubit>().client,
                          child: ChannelPage(),
                          streamChatThemeData: StreamChatThemeData(
                            //input bar
                            messageInputTheme: MessageInputTheme(
                              sendAnimationDuration: Duration(milliseconds: 500),
                            ),

                            //messages styling
                            ownMessageTheme: MessageTheme(
                              messageBorderColor: accentColorDark,
                              messageBackgroundColor: accentColorLight,
                              messageText: TextStyle(
                                color: Color(0xff373737),
                              ),
                            ),
                            otherMessageTheme: MessageTheme(
                              messageBorderColor: Color(0x19000000),
                              messageBackgroundColor: Color(0xF000000),
                              messageText: TextStyle(
                                color: Color(0xff373737),
                              ),
                            ),

                            //list styling
                            channelPreviewTheme: ChannelPreviewTheme(
                              unreadCounterColor: accentColorDark,
                            ),

                            //channel styling
                            channelTheme: ChannelTheme(
                              channelHeaderTheme: ChannelHeaderTheme(
                                color: accentColor,
                                subtitle: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

//region scaffold
// backgroundColor: Colors.white,
// appBar: AppBar(
// title: CircleAvatar(
// radius: 20,
// backgroundImage: AssetImage("assets/images/progile.jpeg"),
// ),
// centerTitle: true,
// leading: IconButton(
// icon: Icon(Icons.arrow_back_outlined),
// onPressed: () {
// Navigator.pop(context);
// },
// ),
// elevation: 0,
// backgroundColor: accentColor,
// ),

//endregion

//region MESSAGE
