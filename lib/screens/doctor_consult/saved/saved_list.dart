import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide BuildContextX;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/list_facilities/list_facilities_cubit.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/saved_agent_contacts/saved_agent_contacts_cubit.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/bloc/saved_facility_contacts/saved_facility_contacts_cubit.dart';
import 'package:pocket_health/bloc/saved_insurance_contacts/saved_insurance_contacts_cubit.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/screens/doctor_consult/call/init_call_dialog.dart';
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

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> with SingleTickerProviderStateMixin {
  String searchDoctorText = '';
  String searchFacilityText = '';
  String searchInsuranceText = '';
  String searchAgentText = '';

  bool showFacilities = false;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<CallBalanceCubit>()..getCallBalance(5);
    context.read<InitializeStreamChatCubit>()..loadInitial();
    tabController = TabController(vsync: this, length: 4);
    searchDoctorText = '';
    searchFacilityText = '';
    searchInsuranceText = '';
    searchAgentText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              BlocBuilder<SavedContactsCubit, SavedContactsState>(
                builder: (context, savedState) {
                  if (savedState is SavedContactsSuccess) {
                    return BlocBuilder<ListPractitionersCubit, ListPractitionersState>(
                      builder: (context, state) {
                        if (state is ListPractitionersLoaded) {
                          List<PractitionerProfileModel> docsDetailsSaved = [];
                          state.practitionerProfiles.forEach((e) {
                            savedState.savedContacts.forEach((element) {
                              if (e.user.toString() == element.replaceAll("docIDTestFive", '')) {
                                return docsDetailsSaved.add(e);
                              }
                            });
                          });

                          final queriedDocs = docsDetailsSaved?.where((element) => element.surname?.toLowerCase()?.contains(searchDoctorText))?.toList();
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
                                            searchDoctorText = val.toLowerCase();
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

                                  //listview
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: searchDoctorText.isEmpty ? docsDetailsSaved.length : queriedDocs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      print('--------|docsnewlength|--------|value -> ${docsDetailsSaved.length.toString()}');
                                      final docDetail = searchDoctorText.isEmpty
                                          ? docsDetailsSaved[index] ?? PractitionerProfileModel()
                                          : queriedDocs[index] ?? PractitionerProfileModel();
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
                                              Icons.person_outlined,
                                              color: Colors.blueAccent,
                                              size: 12.sp,
                                            ),
                                            Text(
                                              docDetail == null
                                                  ? " Practitioner "
                                                  : docDetail.healthInfo.practitioner == null
                                                      ? " null "
                                                      : " ${docDetail.healthInfo.practitioner} ",
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
                            color: Colors.yellow,
                            height: 100,
                            width: 1.sw,
                          );
                        }
                        return Container(
                          color: Colors.indigo,
                          height: 100,
                          width: 1.sw,
                        );
                      },
                    );
                  }

                  if (savedState is SavedContactsFailure) {
                    return Container(
                      color: Colors.pink,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  return Container();
                },
              ),

              //facilities
              BlocBuilder<SavedFacilityContactsCubit, SavedFacilityContactsState>(
                builder: (context, savedState) {
                  if (savedState is SavedFacilityContactsSuccess) {
                    return BlocBuilder<ListFacilitiesCubit, ListFacilitiesState>(
                      builder: (context, state) {
                        if (state is ListFacilitiesSuccess) {
                          List<FacilityProfileModel> facilityDetailsSaved = [];
                          state.facilityProfiles.forEach((e) {
                            savedState.savedFacilityContacts.forEach((element) {
                              if (e.id.toString() == element.replaceAll("facilityIDTestFive", '')) {
                                return facilityDetailsSaved.add(e);
                              }
                            });
                          });

                          final queriedDocsFacilities =
                              facilityDetailsSaved?.where((element) => element.facilityName?.toLowerCase()?.contains(searchFacilityText))?.toList();
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
                                    height: 20.w,
                                    width: 20.w,
                                    child: CircularProgressIndicator(),
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
                                            searchFacilityText = val.toLowerCase();
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

                                  //listview
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: searchFacilityText.isEmpty ? facilityDetailsSaved.length : queriedDocsFacilities.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      print('--------|docsnewlength|--------|value -> ${facilityDetailsSaved.length.toString()}');
                                      final facilityDetail = searchFacilityText.isEmpty
                                          ? facilityDetailsSaved[index] ?? FacilityProfileModel()
                                          : queriedDocsFacilities[index] ?? FacilityProfileModel();
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
                                              Icons.person_outlined,
                                              color: Colors.blueAccent,
                                              size: 12.sp,
                                            ),
                                            Text(
                                              " " + facilityDetail.facilityType + ' ',
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

                                                            context.read<InitializeStreamChatCubit>().initializeFacilityChannel(
                                                                userID, facilityDetail, userCategory, isVerified, facilityHourlyRate);
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
                        if (state is ListFacilitiesLoading) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator(),
                              width: 24,
                              height: 24,
                            ),
                          );
                        }
                        if (state is ListFacilitiesFailure) {
                          return Container(
                            color: Colors.red,
                            height: 100,
                            width: 1.sw,
                          );
                        }
                        return Container(
                          color: Colors.indigo,
                          height: 100,
                          width: 1.sw,
                        );
                      },
                    );
                  }

                  if (savedState is SavedFacilityContactsLoading) {
                    return Container(
                      color: Colors.orange,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  if (savedState is SavedFacilityContactsFailure) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                        width: 24,
                        height: 24,
                      ),
                    );
                  }

                  return Container();
                },
              ),

              //insurance
              BlocBuilder<SavedInsuranceContactsCubit, SavedInsuranceContactsState>(
                builder: (context, savedState) {
                  if (savedState is SavedInsuranceContactsSuccess) {
                    return Consumer(
                      builder: (context, ScopedReader watch, child) {
                        final insurancesModelAsyncVal = watch(healthInsuranceModelProvider);

                        return insurancesModelAsyncVal.when(
                          data: (data) {
                            List<HealthInsuranceModel> insuranceDetailsSaved = [];
                            data.forEach((e) {
                              savedState.savedInsuranceContacts.forEach((element) {
                                if (e.id.toString() == element.replaceAll("insuranceIDTestThree", '')) {
                                  return insuranceDetailsSaved.add(e);
                                }
                              });
                            });

                            final queriedInsurances =
                                insuranceDetailsSaved?.where((element) => element.name?.toLowerCase()?.contains(searchInsuranceText))?.toList();
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
                                      itemCount: searchInsuranceText.isEmpty ? insuranceDetailsSaved.length : queriedInsurances.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final insuranceDetail = searchInsuranceText.isEmpty
                                            ? insuranceDetailsSaved[index] ?? HealthInsuranceModel()
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
                          loading: () => SizedBox.shrink(),
                          error: (err, stack) => SizedBox.shrink(),
                        );
                      },
                    );
                  }

                  if (savedState is SavedContactsFailure) {
                    return Container(
                      color: Colors.pink,
                      height: 100,
                      width: 1.sw,
                    );
                  }

                  return Container();
                },
              ),

              //agent
              BlocBuilder<SavedAgentContactsCubit, SavedAgentContactsState>(
                builder: (context, savedState) {
                  if (savedState is SavedAgentContactsSuccess) {
                    return Consumer(
                      builder: (context, ScopedReader watch, child) {
                        final agentsModelAsyncVal = watch(insuranceAgentModelProvider);

                        return agentsModelAsyncVal.when(
                          data: (data) {
                            List<InsuranceAgentModel> agentDetailsSaved = [];
                            data.forEach((e) {
                              savedState.savedAgentContacts.forEach((element) {
                                if (e.id.toString() == element.replaceAll("agentIDTestThree", '')) {
                                  return agentDetailsSaved.add(e);
                                }
                              });
                            });

                            final queriedAgents = agentDetailsSaved?.where((element) => element.name?.toLowerCase()?.contains(searchAgentText))?.toList();
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
                                      itemCount: searchAgentText.isEmpty ? agentDetailsSaved.length : queriedAgents.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final agentDetail = searchAgentText.isEmpty
                                            ? agentDetailsSaved[index] ?? InsuranceAgentModel()
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
                          loading: () => SizedBox.shrink(),
                          error: (err, stack) => SizedBox.shrink(),
                        );
                      },
                    );
                  }

                  if (savedState is SavedContactsFailure) {
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
