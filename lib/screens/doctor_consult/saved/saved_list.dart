import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/screens/doctor_consult/call/init_call_dialog.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/practitioners/practitioner_profile_screen.dart';
import 'package:pocket_health/screens/practitioners/practitioners_list_screen.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/verified_tag.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  String searchText = '';

  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<CallBalanceCubit>()..getCallBalance(5);
    context.read<InitializeStreamChatCubit>()..loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<SavedContactsCubit, SavedContactsState>(
        builder: (context, savedState) {
          if (savedState is SavedContactsSuccess) {
            return BlocBuilder<ListPractitionersCubit, ListPractitionersState>(
              builder: (context, state) {
                if (state is ListPractitionersLoaded) {
                  List<PractitionerProfileModel> docsDetailsSaved = [];
                  state.practitionerProfiles.forEach((e) {
                    savedState.savedContacts.forEach((element) {
                      if (e.user.toString() == element.replaceAll("docIDTestThree", '')) {
                        return docsDetailsSaved.add(e);
                      }
                    });
                  });

                  final queriedDocs = docsDetailsSaved?.where((element) => element.surname?.toLowerCase()?.contains(searchText))?.toList();
                  return BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
                    listener: (context, streamState) {
                      if (streamState is StreamChannelSuccess) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return StreamChat(
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
                                client: context.read<InitializeStreamChatCubit>().client,
                                child: StreamChannel(
                                  channel: streamState.channel,
                                  child: ChannelPage(),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      if (streamState is StreamChannelError) {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Color(0xff163C4D),
                              duration: Duration(milliseconds: 6000),
                              content: Text(
                                streamState.err,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                      }
                    },
                    builder: (context, streamState) {
                      if (streamState is StreamChannelSuccess) {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(),
                            width: 24,
                            height: 24,
                          ),
                        );
                      }

                      if (streamState is StreamChannelLoading) {
                        return Container(
                          color: Colors.black,
                          height: 100,
                          width: 1.sw,
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //search
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: SizedBox(
                              height: 40.h,
                              child: TextFormField(
                                cursorColor: Colors.grey,
                                onChanged: (val) async {
                                  setState(() {
                                    searchText = val.toLowerCase();
                                  });
                                  setState(() {
                                    searchText = val.toLowerCase();
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0.w),
                                  hintText: "Search for doctor",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.sp,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                    borderSide: BorderSide(color: Color(0xFF00FFFF)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                    borderSide: BorderSide(color: Color(0xFF00FFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //listview
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: searchText.isEmpty ? docsDetailsSaved.length : queriedDocs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              print('--------|docsnewlength|--------|value -> ${docsDetailsSaved.length.toString()}');
                              final docDetail =
                                  searchText.isEmpty ? docsDetailsSaved[index] ?? PractitionerProfileModel() : queriedDocs[index] ?? PractitionerProfileModel();
                              final isVerified = checkVerification(docDetail);

                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PractitionerProfileScreen(
                                        practitionerModel: docDetail,
                                        isVerified: isVerified,
                                      ),
                                    ),
                                  );
                                },
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      docDetail.surname == '' || docDetail.surname.isEmpty ? "Dr. Doctor" : docDetail.surname,
                                      style: TextStyle(
                                        color: Color(0xff515050),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    isVerified ? VerifiedTag() : Container(),
                                  ],
                                ),
                                leading: CircleAvatar(
                                  radius: 24.w,
                                  backgroundImage: AssetImage("assets/images/progile.jpeg"),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.blueAccent,
                                      size: 12.sp,
                                    ),
                                    Text(
                                      " " + docDetail.healthInfo.practitioner ?? " ",
                                      style: TextStyle(
                                        color: Color(0xff515050),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 150.w,
                                  child: Row(
                                    children: [
                                      //chat
                                      BlocBuilder<LoginBloc, LoginState>(
                                        builder: (context, loginState) {
                                          if (loginState is LoginLoaded) {
                                            final userID = loginState.loginModel.user.fullNames.split(' ').last;
                                            final userCategory = loginState.loginModel.user.userCategory;

                                            return BlocBuilder<InitializeStreamChatCubit, InitializeStreamChatState>(
                                              builder: (context, state) {
                                                return IconButton(
                                                  icon: Icon(
                                                    Icons.chat_bubble_outline,
                                                    size: 22.sp,
                                                    color: accentColorDark,
                                                  ),
                                                  onPressed: () {
                                                    context.read<InitializeStreamChatCubit>().initializeChannel(userID, docDetail, userCategory, isVerified);
                                                  },
                                                );
                                              },
                                            );
                                          }
                                          return IconButton(
                                            icon: Icon(
                                              Icons.chat_bubble_outline,
                                              size: 22.sp,
                                              color: accentColorDark,
                                            ),
                                            onPressed: () {},
                                          );
                                        },
                                      ),

                                      //video
                                      IconButton(
                                        icon: Icon(
                                          MdiIcons.videoOutline,
                                          size: 22.sp,
                                          color: accentColorDark,
                                        ),
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return InitCallDialog(
                                                from: "callhistory",
                                                videoMuted: false,
                                                docDetail: docDetail,
                                                isVerified: isVerified,
                                              );
                                            },
                                          );
                                        },
                                      ),

                                      //call
                                      IconButton(
                                        icon: Icon(
                                          MdiIcons.phone,
                                          size: 22.sp,
                                          color: accentColorDark,
                                        ),
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return InitCallDialog(
                                                from: "callhistory",
                                                videoMuted: true,
                                                docDetail: docDetail,
                                                isVerified: isVerified,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                if (state is ListPractitionersLoading) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
                      width: 24,
                      height: 24,
                    ),
                  );
                }
                if (state is ListPractitionersFailure) {
                  return Container(
                    color: Colors.black,
                    height: 100,
                    width: 1.sw,
                  );
                }
                return Container(
                  color: Colors.black,
                  height: 100,
                  width: 1.sw,
                );
              },
            );
          }

          if (savedState is SavedContactsFailure) {
            return Container(
              color: Colors.black,
              height: 100,
              width: 1.sw,
            );
          }

          return Container();
        },
      ),
    );
  }
}
