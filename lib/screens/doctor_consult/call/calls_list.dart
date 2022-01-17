import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide BuildContextX;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_agent_call_history/fetch_agent_call_history_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/bloc/fetch_facility_call_history/fetch_facility_call_history_cubit.dart';
import 'package:pocket_health/bloc/fetch_insurance_call_history/fetch_insurance_call_history_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/screens/doctor_consult/call/init_call_dialog.dart';
import 'package:pocket_health/screens/doctor_consult/call/top_up_account.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/facilities/facilities_list_screen.dart';
import 'package:pocket_health/screens/facilities/facility_profile_screen.dart';
import 'package:pocket_health/screens/health_insurance/insurance_agent_profile_page.dart';
import 'package:pocket_health/screens/health_insurance/insurance_profile_page.dart';
import 'package:pocket_health/screens/practitioners/practitioner_profile_screen.dart';
import 'package:pocket_health/screens/practitioners/practitioners_list_screen.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/verified_tag.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'init_call_dialog.dart';
import 'top_up_account.dart';

class CallsList extends StatefulWidget {
  final LoginModel loginModel;

  const CallsList({Key key, this.loginModel}) : super(key: key);

  @override
  _CallsListState createState() => _CallsListState();
}

class _CallsListState extends State<CallsList> with SingleTickerProviderStateMixin {
  String searchDoctorText = "";
  String searchFacilityText = "";
  String searchInsuranceText = "";
  String searchAgentText = "";

  TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<FetchFacilityCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<FetchAgentCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<FetchInsuranceCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<CallBalanceCubit>()..getCallBalance(5);
    context.read<InitializeStreamChatCubit>()..loadInitial();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Ssential Phone Call',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13.sp,
            ),
          ),
          dense: true,
          subtitle: Text(
            'Call at affordable rates',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
            ),
          ),
          leading: SizedBox(
            height: 26.w,
            width: 26.w,
            child: Image(
              image: AssetImage("assets/images/phone.png"),
            ),
          ),
          trailing: RawMaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            elevation: 0.0,
            hoverElevation: 0.0,
            fillColor: Colors.orangeAccent,
            shape: StadiumBorder(),
            child: Text(
              'TOP UP',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TopUpAccount(),
                ),
              );
            },
          ),
        ),
        Divider(height: 0.5, color: Colors.black26),
        TabBar(
          tabs: [
            Tab(text: "Doctors"),
            Tab(text: "Facilities"),
            Tab(text: "Insurances"),
            Tab(text: "Agents"),
          ],
          controller: tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              //doctors
              BlocBuilder<FetchCallHistoryCubit, FetchCallHistoryState>(
                builder: (context, historyState) {
                  if (historyState is FetchCallHistoryLoading) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                        width: 24,
                        height: 24,
                      ),
                    );
                  }

                  if (historyState is FetchCallHistorySuccess) {
                    final allDocsCalled = historyState.allDoctorsCalled;
                    final allCallHistory = historyState.allCallHistory;
                    final queriedDocs = allDocsCalled?.where((element) => element?.surname?.toLowerCase()?.contains(searchDoctorText))?.toList();
                    List<CallHistoryModel> queriedHistory = [];
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //search
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: SizedBox(
                                height: 40.h,
                                child: TextFormField(
                                  cursorColor: Colors.grey,
                                  onChanged: (val) async {
                                    setState(() {
                                      searchDoctorText = val.toLowerCase();
                                    });
                                    final list = await getCallHistoryByDocID(queriedDocs, allCallHistory);
                                    setState(() {
                                      queriedHistory = list;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    fillColor: accentColorLight,
                                    filled: true,
                                    focusColor: accentColorLight,
                                    contentPadding: EdgeInsets.all(10.0.w),
                                    hintText: "Search for doctors",
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                      borderSide: BorderSide(color: accentColorDark),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                      borderSide: BorderSide(color: accentColorDark),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Divider(height: 0.5, color: Colors.black26),

                            ListView.separated(
                              separatorBuilder: (c, cc) {
                                return Divider(height: 0.5, color: Colors.white70);
                              },
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: searchDoctorText.isEmpty ? allDocsCalled.length : queriedDocs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var callHistoryA = CallHistoryModel();
                                var callHistoryB = CallHistoryModel();
                                allCallHistory
                                  ..sort((a, b) {
                                    callHistoryA = a;
                                    callHistoryB = b;
                                    return DateTime.parse(b.endTime).compareTo(DateTime.parse(a.endTime));
                                  });
                                allDocsCalled..sort((a, b) => DateTime.parse(callHistoryB.endTime).compareTo(DateTime.parse(callHistoryA.endTime)));
                                final docDetail = searchDoctorText.isEmpty
                                    ? allDocsCalled.toList()[index] ?? PractitionerProfileModel()
                                    : queriedDocs.toList()[index] ?? PractitionerProfileModel();
                                final callDetail =
                                    queriedHistory.isEmpty ? allCallHistory[index] ?? CallHistoryModel() : queriedHistory.toList()[index] ?? CallHistoryModel();
                                final isVerified = checkVerification(docDetail);
                                final formattedEndtime = DateFormat().add_EEEE().add_jm().format(DateTime.parse(callDetail.endTime)).toString();

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
                                      SizedBox(width: 4.w),
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
                                        " " + formattedEndtime ?? " ",
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
                                                      context
                                                          .read<InitializeStreamChatCubit>()
                                                          .initializePractitionerChannel(userID, docDetail, userCategory, isVerified);
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
                                                  from: "doc-callhistory",
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
                                                  from: "doc-callhistory",
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

                  if (historyState is FetchCallHistoryFailure) {
                    return Container(
                      color: Colors.black,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  return Container();
                },
              ),

              //facilities
              BlocBuilder<FetchFacilityCallHistoryCubit, FetchFacilityCallHistoryState>(
                builder: (context, historyState) {
                  if (historyState is FetchFacilityCallHistoryLoading) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                        width: 24,
                        height: 24,
                      ),
                    );
                  }

                  if (historyState is FetchFacilityCallHistorySuccess) {
                    final allFacilitiesCalled = historyState.allFacilitiesCalled;
                    final allCallHistory = historyState.allCallHistory;
                    final queriedFacilities =
                        allFacilitiesCalled?.where((element) => element?.facilityName?.toLowerCase()?.contains(searchFacilityText))?.toList();
                    List<FacilityCallHistoryModel> queriedHistory = [];
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //search
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: SizedBox(
                                height: 40.h,
                                child: TextFormField(
                                  cursorColor: Colors.grey,
                                  onChanged: (val) async {
                                    setState(() {
                                      searchFacilityText = val.toLowerCase();
                                    });
                                    final list = await getFacilityCallHistoryByFacilityID(queriedFacilities, allCallHistory);
                                    setState(() {
                                      queriedHistory = list;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    fillColor: accentColorLight,
                                    filled: true,
                                    focusColor: accentColorLight,
                                    contentPadding: EdgeInsets.all(10.0.w),
                                    hintText: "Search for facilities",
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                      borderSide: BorderSide(color: accentColorDark),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                      borderSide: BorderSide(color: accentColorDark),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Divider(height: 0.5, color: Colors.black26),

                            ListView.separated(
                              separatorBuilder: (c, cc) {
                                return Divider(height: 0.5, color: Colors.white70);
                              },
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: searchFacilityText.isEmpty ? allFacilitiesCalled.length : queriedFacilities.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var callHistoryA = FacilityCallHistoryModel();
                                var callHistoryB = FacilityCallHistoryModel();
                                allCallHistory
                                  ..sort((a, b) {
                                    callHistoryA = a;
                                    callHistoryB = b;
                                    return DateTime.parse(b.endTime).compareTo(DateTime.parse(a.endTime));
                                  });
                                allFacilitiesCalled..sort((a, b) => DateTime.parse(callHistoryB.endTime).compareTo(DateTime.parse(callHistoryA.endTime)));
                                final facilityDetail = searchFacilityText.isEmpty
                                    ? allFacilitiesCalled.toList()[index] ?? FacilityProfileModel()
                                    : queriedFacilities.toList()[index] ?? FacilityProfileModel();
                                final callDetail = queriedHistory.isEmpty
                                    ? allCallHistory[index] ?? FacilityCallHistoryModel()
                                    : queriedHistory.toList()[index] ?? FacilityCallHistoryModel();
                                final formattedEndtime = DateFormat().add_EEEE().add_jm().format(DateTime.parse(callDetail.endTime)).toString();
                                final isVerified = checkFacilityVerification(facilityDetail);

                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FacilityProfileScreen(
                                          facilityProfileModel: facilityDetail,
                                          isVerified: isVerified,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        facilityDetail.facilityName == '' || facilityDetail.facilityName.isEmpty ? "FacilityName" : facilityDetail.facilityName,
                                        style: TextStyle(
                                          color: Color(0xff515050),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
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
                                        " " + formattedEndtime ?? " ",
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
                                                    onPressed: () async {
                                                      final apiService = ApiService(http.Client());
                                                      final hourlyRate = await apiService.fetchFacilityHourlyRate();
                                                      final facilityHourlyRate = int.parse(hourlyRate.split(".").first);

                                                      context
                                                          .read<InitializeStreamChatCubit>()
                                                          .initializeFacilityChannel(userID, facilityDetail, userCategory, isVerified, facilityHourlyRate);
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
                                            final apiService = ApiService(http.Client());
                                            final hourlyRate = await apiService.fetchFacilityHourlyRate();
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return InitCallDialog(
                                                  from: "facility-callhistory",
                                                  videoMuted: false,
                                                  facilityDetail: facilityDetail,
                                                  facilityHourlyRate: int.parse(hourlyRate.split(".").first),
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
                                            final apiService = ApiService(http.Client());
                                            final hourlyRate = await apiService.fetchFacilityHourlyRate();
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return InitCallDialog(
                                                  from: "facility-callhistory",
                                                  videoMuted: false,
                                                  facilityDetail: facilityDetail,
                                                  facilityHourlyRate: int.parse(hourlyRate.split(".").first),
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

                  if (historyState is FetchCallHistoryFailure) {
                    return Container(
                      color: Colors.black,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  return Container();
                },
              ),

              //insurances
              BlocBuilder<FetchInsuranceCallHistoryCubit, FetchInsuranceCallHistoryState>(
                builder: (context, historyState) {
                  if (historyState is FetchInsuranceCallHistorySuccess) {
                    return Consumer(
                      builder: (context, ScopedReader watch, child) {
                        final insurancesModelAsyncVal = watch(healthInsuranceModelProvider);

                        return insurancesModelAsyncVal.when(
                          data: (data) {
                            final allInsurancesCalled = historyState.allInsurancesCalled;
                            final allCallHistory = historyState.allCallHistory;
                            final queriedInsurances =
                                allInsurancesCalled?.where((element) => element?.name?.toLowerCase()?.contains(searchInsuranceText))?.toList();

                            List<FacilityCallHistoryModel> queriedHistory = [];

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
                                if (streamState is StreamChannelLoading) {
                                  return Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: CircularProgressIndicator(),
                                      width: 24,
                                      height: 24,
                                    ),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10.h),

                                    //search
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w, left: 10.w),
                                      child: SizedBox(
                                        height: 40.h,
                                        child: TextFormField(
                                          cursorColor: Colors.grey,
                                          onChanged: (val) async {
                                            setState(() {
                                              searchInsuranceText = val.toLowerCase();
                                            });
                                          },
                                          decoration: InputDecoration(
                                            fillColor: accentColorLight,
                                            filled: true,
                                            focusColor: accentColorLight,
                                            contentPadding: EdgeInsets.all(10.0.w),
                                            hintText: "Search for insurances",
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.black,
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                              borderSide: BorderSide(color: accentColorDark),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                              borderSide: BorderSide(color: accentColorDark),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10.h),

                                    Divider(height: 0.5, color: Colors.black26),

                                    //listview
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: searchInsuranceText.isEmpty ? allInsurancesCalled.length : queriedInsurances.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final insuranceDetail = searchInsuranceText.isEmpty
                                            ? allInsurancesCalled[index] ?? HealthInsuranceModel()
                                            : queriedInsurances[index] ?? HealthInsuranceModel();

                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => InsuranceProfilePage(
                                                  insuranceModel: insuranceDetail,
                                                ),
                                              ),
                                            );
                                          },
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                insuranceDetail.name == '' || insuranceDetail.name.isEmpty ? " Insurance" : insuranceDetail.name,
                                                style: TextStyle(
                                                  color: Color(0xff515050),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                            ],
                                          ),
                                          leading: CircleAvatar(
                                            radius: 24.w,
                                            backgroundImage: AssetImage("assets/images/progile.jpeg"),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Icon(
                                                Icons.person_outlined,
                                                color: Colors.blueAccent,
                                                size: 12.sp,
                                              ),
                                              Text(
                                                " Insurance",
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
                                                              context
                                                                  .read<InitializeStreamChatCubit>()
                                                                  .initializeInsuranceChannel(userID, insuranceDetail, userCategory, false);
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
                                                    // await showDialog(
                                                    //   context: context,
                                                    //   builder: (dialogContext) {
                                                    //     return InitCallDialog(
                                                    //       from: "agent-callhistory",
                                                    //       videoMuted: false,
                                                    //       agentDetail: agentDetail,
                                                    //       isVerified: false,
                                                    //       agentHourlyRate: 10,
                                                    //     );
                                                    //   },
                                                    // );
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
                                                    // await showDialog(
                                                    //   context: context,
                                                    //   builder: (dialogContext) {
                                                    //     return InitCallDialog(
                                                    //       from: "agent-callhistory",
                                                    //       videoMuted: false,
                                                    //       agentDetail: agentDetail,
                                                    //       isVerified: false,
                                                    //       agentHourlyRate: 10,
                                                    //     );
                                                    //   },
                                                    // );
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
                          },
                          loading: () => Container(
                            color: Colors.yellow,
                            height: 100,
                            width: 1.sw,
                          ),
                          error: (err, stack) => Container(
                            color: Colors.red,
                            height: 100,
                            width: 1.sw,
                          ),
                        );
                      },
                    );
                  }

                  if (historyState is SavedContactsFailure) {
                    return Container(
                      color: Colors.pink,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  return Container();
                },
              ),

              //agents
              BlocBuilder<FetchAgentCallHistoryCubit, FetchAgentCallHistoryState>(
                builder: (context, historyState) {
                  if (historyState is FetchAgentCallHistorySuccess) {
                    return Consumer(
                      builder: (context, ScopedReader watch, child) {
                        final agentsModelAsyncVal = watch(insuranceAgentModelProvider);

                        return agentsModelAsyncVal.when(
                          data: (data) {
                            final allAgentsCalled = historyState.allAgentsCalled;
                            print('--------|allAgentsCalled|--------|value -> ${allAgentsCalled.length.toString()}');
                            final queriedAgents = allAgentsCalled?.where((element) => element?.name?.toLowerCase()?.contains(searchAgentText))?.toList();

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
                                if (streamState is StreamChannelLoading) {
                                  return Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: CircularProgressIndicator(),
                                      width: 24,
                                      height: 24,
                                    ),
                                  );
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10.h),

                                    //search
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w, left: 10.w),
                                      child: SizedBox(
                                        height: 40.h,
                                        child: TextFormField(
                                          cursorColor: Colors.grey,
                                          onChanged: (val) async {
                                            setState(() {
                                              searchAgentText = val.toLowerCase();
                                            });
                                          },
                                          decoration: InputDecoration(
                                            fillColor: accentColorLight,
                                            filled: true,
                                            focusColor: accentColorLight,
                                            contentPadding: EdgeInsets.all(10.0.w),
                                            hintText: "Search for agents",
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.black,
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                              borderSide: BorderSide(color: accentColorDark),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                              borderSide: BorderSide(color: accentColorDark),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10.h),

                                    Divider(height: 0.5, color: Colors.black26),

                                    //listview
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: searchAgentText.isEmpty ? allAgentsCalled.length : queriedAgents.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final agentDetail = searchAgentText.isEmpty
                                            ? allAgentsCalled[index] ?? InsuranceAgentModel()
                                            : queriedAgents[index] ?? InsuranceAgentModel();

                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => InsuranceAgentProfilePage(
                                                  agentModel: agentDetail,
                                                ),
                                              ),
                                            );
                                          },
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                agentDetail.name == '' || agentDetail.name.isEmpty ? "Agent" : agentDetail.name,
                                                style: TextStyle(
                                                  color: Color(0xff515050),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                            ],
                                          ),
                                          leading: CircleAvatar(
                                            radius: 24.w,
                                            backgroundImage: AssetImage("assets/images/progile.jpeg"),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Icon(
                                                Icons.person_outlined,
                                                color: Colors.blueAccent,
                                                size: 12.sp,
                                              ),
                                              Text(
                                                "Agent",
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
                                                              context
                                                                  .read<InitializeStreamChatCubit>()
                                                                  .initializeInsuranceAgentChannel(userID, agentDetail, userCategory, false);
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
                                                          from: "agent-callhistory",
                                                          videoMuted: false,
                                                          agentDetail: agentDetail,
                                                          isVerified: false,
                                                          agentHourlyRate: 10,
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
                                                          from: "agent-callhistory",
                                                          videoMuted: false,
                                                          agentDetail: agentDetail,
                                                          isVerified: false,
                                                          agentHourlyRate: 10,
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
                          },
                          loading: () => Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          error: (err, stack) => Container(
                            color: Colors.red,
                            height: 100,
                            width: 1.sw,
                          ),
                        );
                      },
                    );
                  }

                  if (historyState is FetchAgentCallHistoryFailure) {
                    return Container(
                      color: Colors.pink,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<List<CallHistoryModel>> getCallHistoryByDocID(queriedDocs, allCallHistory) async {
  List<CallHistoryModel> all = [];
  for (final doc in queriedDocs) {
    final history = allCallHistory.lastWhere((element) => element.profile == doc.user);
    print('--------|ended|--------|value -> ${history.endTime.toString()}');

    all.add(history);
  }
  print('--------|all|--------|value -> ${all[0].user.toString()}');

  return all;
}

Future<List<FacilityCallHistoryModel>> getFacilityCallHistoryByFacilityID(queriedFacilities, allCallHistory) async {
  List<FacilityCallHistoryModel> all = [];
  for (final facility in queriedFacilities) {
    final history = allCallHistory.lastWhere((element) => element.profile == facility.user);
    print('--------|ended|--------|value -> ${history.endTime.toString()}');

    all.add(history);
  }
  print('--------|all|--------|value -> ${all[0].user.toString()}');

  return all;
}
