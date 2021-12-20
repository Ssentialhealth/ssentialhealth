import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide BuildContextX;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/health_insurance/insurance_agent_profile_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'filter_agents_screen.dart';

class ListAgentsPage extends StatefulWidget {
  const ListAgentsPage({
    Key key,
  }) : super(key: key);

  @override
  _ListAgentsPageState createState() => _ListAgentsPageState();
}

class _ListAgentsPageState extends State<ListAgentsPage> {
  String filterByName;

  @override
  void initState() {
    super.initState();
    context.read<InitializeStreamChatCubit>()..loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "View and Contact Agents",
          style: appBarStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  //search bar
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SizedBox(
                        height: 40.h,
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          onChanged: (val) async {
                            setState(() {
                              filterByName = val.toLowerCase();
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0.w),
                            hintText: "Search for Agents",
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
                  ),

                  //filter
                  MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    focusElevation: 0.0,
                    disabledElevation: 0.0,
                    color: Color(0xff1A5864),
                    height: 40.h,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.filterMenu,
                          color: Colors.white,
                          size: 20.r,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.containsKey('filterAgentsByPrice') ? prefs.remove('filterAgentsByPrice') : null;
                      prefs.containsKey('filterAgentsByDistance') ? prefs.remove('filterAgentsByDistance') : null;
                      prefs.containsKey('filterAgentsByCountry') ? prefs.remove('filterAgentsByCountry') : null;
                      prefs.containsKey('sortAgentsByCheapest') ? prefs.remove('sortAgentsByCheapest') : null;
                      prefs.containsKey('filterAgentsByAvailability') ? prefs.remove('filterAgentsByAvailability') : null;
                      prefs.containsKey('sortAgentsByNearest') ? prefs.remove('sortAgentsByNearest') : null;
                      prefs.containsKey('filterAgentsBySpeciality') ? prefs.remove('filterAgentsBySpeciality') : null;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return FilterAgentsScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ScopedReader watch, child) {
                final agentsModelAsyncVal = watch(insuranceAgentModelProvider);
                return agentsModelAsyncVal.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final agent = data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InsuranceAgentProfilePage(agentModel: agent),
                              ),
                            );
                          },
                          child: Container(
                            height: 130.w,
                            clipBehavior: Clip.hardEdge,
                            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                            margin: EdgeInsets.only(bottom: 10.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xC000000),
                                  blurRadius: 4.w,
                                  spreadRadius: 2.w,
                                ),
                              ],
                            ),
                            child: Hero(
                              tag: "agent-profile-${agent.id}",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //avi / rating
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //avi
                                        CircleAvatar(
                                          radius: 32.w,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: agent.profileImgUrl == "" || agent.profileImgUrl == null
                                                ? SizedBox.shrink()
                                                : Image(
                                                    image: NetworkImage(agent.profileImgUrl),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        //rating
                                        Text(
                                          '4.6/5',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffF06E20),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(width: 20.w),

                                    //details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          //name / verified / bookmark
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              //name
                                              Text(
                                                agent.name,
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  color: Color(0xff242424),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),

                                              Spacer(),

                                              //bookmark
                                              // BlocBuilder<SavedFacilityContactsCubit, SavedFacilityContactsState>(
                                              //   builder: (context, state) {
                                              //     if (state is SavedFacilityContactsSuccess) {
                                              //       final isSaved = state.savedFacilityContacts.contains("facilityIDTestThree" + '${facilityProfileModel.id.toString()}');
                                              //
                                              //       return GestureDetector(
                                              //         child: Icon(
                                              //           isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                              //           size: 20.w,
                                              //           color: isSaved ? Color(0xff0e0e0e) : Color(0xff242424),
                                              //         ),
                                              //         onTap: () async {
                                              //           setState(() {
                                              //             saveContactVal = !isSaved;
                                              //           });
                                              //           context.read<SavedFacilityContactsCubit>()
                                              //             ..addRemoveContacts(saveContactVal, "facilityIDTestThree" + "${facilityProfileModel.id.toString()}");
                                              //         },
                                              //       );
                                              //     }
                                              //     return Icon(
                                              //       Icons.bookmark_outline,
                                              //       size: 20.w,
                                              //       color: Color(0xff242424),
                                              //     );
                                              //   },
                                              // ),
                                            ],
                                          ),

                                          //location / get directions
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              //location
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 15.w,
                                                    color: Color(0xff1A5864),
                                                  ),
                                                  SizedBox(
                                                    width: 150.w,
                                                    child: Text(
                                                      agent.location ?? "N/A",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Color(0xff242424),
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Spacer(),
                                              //get directions
                                              Text(
                                                'Get Directions',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0xff1A5864),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 4.h),

                                          //view profile btn / book appointment btn
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RawMaterialButton(
                                                  elevation: 0.0,
                                                  fillColor: Colors.white,
                                                  padding: EdgeInsets.zero,
                                                  shape: ContinuousRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    side: BorderSide(color: accentColorDark),
                                                  ),
                                                  child: Text(
                                                    'View Profile',
                                                    style: TextStyle(
                                                      color: Color(0xff1A5864),
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => InsuranceAgentProfilePage(agentModel: agent),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              BlocBuilder<LoginBloc, LoginState>(
                                                builder: (context, state) {
                                                  if (state is LoginLoaded) {
                                                    final userID = state.loginModel.user.fullNames.split(' ').last;
                                                    final userCategory = state.loginModel.user.userCategory;

                                                    return BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
                                                      listener: (context, state) {
                                                        if (state is StreamChannelError) {
                                                          ScaffoldMessenger.of(context)
                                                            ..clearSnackBars()
                                                            ..showSnackBar(
                                                              SnackBar(
                                                                behavior: SnackBarBehavior.floating,
                                                                backgroundColor: Color(0xff163C4D),
                                                                duration: Duration(milliseconds: 6000),
                                                                content: Text(
                                                                  state.err,
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                        }
                                                      },
                                                      builder: (context, state) {
                                                        return Expanded(
                                                          child: RawMaterialButton(
                                                            elevation: 0.0,
                                                            fillColor: accentColorDark,
                                                            padding: EdgeInsets.zero,
                                                            shape: ContinuousRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8.r),
                                                              side: BorderSide(color: accentColorDark),
                                                            ),
                                                            child: Text(
                                                              'Get Quote',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.sp,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              if (state is StreamChannelInitial) {
                                                                context
                                                                    .read<InitializeStreamChatCubit>()
                                                                    .initializeInsuranceAgentChannel(userID, agent, userCategory, false);
                                                                Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) => Scaffold(
                                                                      backgroundColor: Colors.white,
                                                                      body: BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
                                                                        listener: (context, state) {
                                                                          if (state is StreamChannelSuccess) {
                                                                            Navigator.of(context).pushReplacement(
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
                                                                                      channel: state.channel,
                                                                                      child: ChannelPage(),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            );
                                                                          }
                                                                        },
                                                                        builder: (context, state) {
                                                                          return Center(
                                                                            child: Container(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                  return Expanded(
                                                    child: RawMaterialButton(
                                                      elevation: 0.0,
                                                      fillColor: accentColorDark,
                                                      padding: EdgeInsets.zero,
                                                      shape: ContinuousRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.r),
                                                        side: BorderSide(color: accentColorDark),
                                                      ),
                                                      child: Text(
                                                        'Get Quote',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.sp,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  error: (err, stack) => Text(
                    "err",
                    style: TextStyle(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
