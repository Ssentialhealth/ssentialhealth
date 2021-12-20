import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/bloc/fetch_facility_call_history/fetch_facility_call_history_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/screens/doctor_consult/call/init_call_dialog.dart';
import 'package:pocket_health/screens/doctor_consult/call/top_up_account.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/facilities/facilities_list_screen.dart';
import 'package:pocket_health/screens/facilities/facility_profile_screen.dart';
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
  String searchText = "";
  String searchFacilityText = "";

  bool showFacilities = false;
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<FetchFacilityCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<CallBalanceCubit>()..getCallBalance(5);
    context.read<InitializeStreamChatCubit>()..loadInitial();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            showFacilities
                ? BlocBuilder<FetchFacilityCallHistoryCubit, FetchFacilityCallHistoryState>(
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

                                Divider(height: 0.5, color: accentColorDark),

                                SizedBox(height: 10.h),

                                //switcher
                                Center(
                                  child: Container(
                                    width: 194.w,
                                    height: 32.0.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(
                                          color: Colors.grey[300],
                                          elevation: 0.0,
                                          height: 32.0.h,
                                          minWidth: 76.w,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                                          child: Text(
                                            'Doctors',
                                            style: TextStyle(
                                              color: Color(0xff777a7e),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showFacilities = false;
                                              searchFacilityText = "";
                                              searchText = "";
                                            });
                                          },
                                        ),
                                        MaterialButton(
                                          color: accentColorDark,
                                          elevation: 0.0,
                                          height: 32.0.h,
                                          minWidth: 76.w,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                                          child: Text(
                                            'Facilities',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showFacilities = true;
                                              searchFacilityText = "";
                                              searchText = "";
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

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

                                SizedBox(height: 10.h),

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
                                            facilityDetail.facilityName == '' || facilityDetail.facilityName.isEmpty
                                                ? "FacilityName"
                                                : facilityDetail.facilityName,
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
                  )
                : BlocBuilder<FetchCallHistoryCubit, FetchCallHistoryState>(
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
                        final queriedDocs = allDocsCalled?.where((element) => element?.surname?.toLowerCase()?.contains(searchText))?.toList();
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

                                Divider(height: 0.5, color: accentColorDark),

                                SizedBox(height: 10.h),

                                //switcher
                                Center(
                                  child: Container(
                                    width: 194.w,
                                    height: 32.0.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(
                                          color: accentColorDark,
                                          elevation: 0.0,
                                          height: 32.0.h,
                                          minWidth: 76.w,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                                          child: Text(
                                            'Doctors',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showFacilities = false;
                                              searchFacilityText = "";
                                              searchText = "";
                                            });
                                          },
                                        ),
                                        MaterialButton(
                                          color: Colors.grey[300],
                                          elevation: 0.0,
                                          height: 32.0.h,
                                          minWidth: 76.w,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                                          child: Text(
                                            'Facilities',
                                            style: TextStyle(
                                              color: Color(0xff777a7e),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showFacilities = true;
                                              searchFacilityText = "";
                                              searchText = "";
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

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
                                          searchText = val.toLowerCase();
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

                                SizedBox(height: 10.h),

                                Divider(height: 0.5, color: Colors.black26),

                                ListView.separated(
                                  separatorBuilder: (c, cc) {
                                    return Divider(height: 0.5, color: Colors.white70);
                                  },
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: searchText.isEmpty ? allDocsCalled.length : queriedDocs.length,
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
                                    final docDetail = searchText.isEmpty
                                        ? allDocsCalled.toList()[index] ?? PractitionerProfileModel()
                                        : queriedDocs.toList()[index] ?? PractitionerProfileModel();
                                    final callDetail = queriedHistory.isEmpty
                                        ? allCallHistory[index] ?? CallHistoryModel()
                                        : queriedHistory.toList()[index] ?? CallHistoryModel();
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
          ],
        ),
      ),
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
