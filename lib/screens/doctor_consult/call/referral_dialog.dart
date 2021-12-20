import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/models/user_profile_model.dart';
import 'package:pocket_health/repository/all_users_service.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ReferralDialog extends StatefulWidget {
  final String referralType;
  final int patientID;
  final String userCategory;
  const ReferralDialog({
    Key key,
    this.patientID,
    this.userCategory,
    this.referralType,
  }) : super(key: key);

  @override
  _ReferralDialogState createState() => _ReferralDialogState();
}

class _ReferralDialogState extends State<ReferralDialog> {
  String request;
  String doctorID;
  String facilityID;

  FacilityProfileModel facility;
  PractitionerProfileModel doctor;

  @override
  void initState() {
    super.initState();
    context.read<InitializeStreamChatCubit>()..loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
      child: SingleChildScrollView(
        reverse: true,
        child: BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
          listener: (context, state) {
            if (state is StreamChannelSuccess) {
              Map<String, dynamic> referral = {
                "patientID": widget.patientID,
                "request": request,
                "doctor": doctor,
                "facility": facility,
              };

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
                        channel: state.channel,
                        child: ChannelPage(referral: referral, referralType:widget.referralType),
                      ),
                    );
                  },
                ),
              );
            }

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
            return Container(
              width: 1.sw,
              height: 575,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        'Referral Dialog',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter the following information',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //patient
                        Text(
                          'Patient ID:',
                          style: TextStyle(
                            fontSize: 15,
                            color: accentColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: SizedBox(
                                  height: 40.h,
                                  child: TextFormField(
                                    cursorColor: Colors.grey,
                                    enabled: false,
                                    onChanged: (val) async {},
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0.w),
                                      hintText: "${widget.patientID}" + " (This value can't be edited)",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        //test
                        Text(
                          'Request:',
                          style: TextStyle(
                            fontSize: 15,
                            color: accentColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: SizedBox(
                                  height: 40.h,
                                  child: TextFormField(
                                    cursorColor: Colors.grey,
                                    onChanged: (val) async {
                                      setState(() {
                                        request = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0.w),
                                      hintText: "Enter request",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        //doctor
                        Text(
                          'Doctor ID: (Where applicable)',
                          style: TextStyle(
                            fontSize: 15,
                            color: accentColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: SizedBox(
                                  height: 40.h,
                                  child: TextFormField(
                                    cursorColor: Colors.grey,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChanged: (val) async {
                                      setState(() {
                                        doctorID = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0.w),
                                      hintText: "Enter Doctor ID of whom you wish to refer this patient to",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        //facility
                        Text(
                          'Facility ID: (Where applicable)',
                          style: TextStyle(
                            fontSize: 15,
                            color: accentColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: SizedBox(
                                  height: 40.h,
                                  child: TextFormField(
                                    cursorColor: Colors.grey,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChanged: (val) async {
                                      setState(() {
                                        facilityID = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0.w),
                                      hintText: "Enter Hospital ID of where you wish to refer this patient to",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                                        borderSide: BorderSide(color: accentColorDark, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        //send message
                        Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                elevation: 0.0,
                                fillColor: accentColorDark,
                                padding: EdgeInsets.zero,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  side: BorderSide(color: accentColorDark),
                                ),
                                child: Text(
                                  'Send Referral',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () async {
                                  ApiService api = ApiService(http.Client());

                                  //TODO: add real values
                                  final userProfile = await fetchUserDetail(5);
                                  final docDetail = await api.fetchDocDetails(16);
                                  final facilityDetail = await api.fetchFacilityDetails(4);

                                  setState(() {
                                    doctor = docDetail;
                                    facility = facilityDetail;
                                  });
                                  if (widget.referralType == "patient") {
                                    context
                                        .read<InitializeStreamChatCubit>()
                                        .initializePatientChannel(userProfile.surname.split(" ").first, userProfile, widget.userCategory, false);
                                  } else if (widget.referralType == 'facility') {
                                    context
                                        .read<InitializeStreamChatCubit>()
                                        .initializeFacilityChannel(facilityDetail.facilityName.split(" ").first, facilityDetail, widget.userCategory, false, 10);
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<UserProfileModel> fetchUserDetail(int userID) async {
  AllUsersService allUsersService = AllUsersService();
  final users = await allUsersService.fetchAllUsers();
  print(users.first.surname);
  return users.firstWhere((element) => element.user == userID);
}
