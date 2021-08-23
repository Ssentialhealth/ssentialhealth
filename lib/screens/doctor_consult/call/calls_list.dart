import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/utils/constants.dart';

import 'call_page.dart';
import 'top_up_account.dart';

class CallsList extends StatefulWidget {
  final LoginModel loginModel;

  const CallsList({Key key, this.loginModel}) : super(key: key);

  @override
  _CallsListState createState() => _CallsListState();
}

class _CallsListState extends State<CallsList> {
  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<CallBalanceCubit>()..getCallBalance(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              title: Text(
                'Top Up Account',
              ),
              leading: Icon(
                MdiIcons.bank,
                color: Colors.orange,
              ),
              trailing: RawMaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
                constraints: BoxConstraints(
                  minWidth: 100.w,
                  maxWidth: 100.w,
                ),
                elevation: 0.0,
                hoverElevation: 0.0,
                fillColor: Colors.orangeAccent,
                shape: StadiumBorder(),
                child: Row(
                  children: [
                    Text(
                      ' TOP UP ',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      MdiIcons.cash,
                      size: 22.sp,
                      color: Color(0xff242424),
                    ),
                  ],
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
            BlocBuilder<FetchCallHistoryCubit, FetchCallHistoryState>(
              builder: (context, state) {
                if (state is FetchCallHistoryLoading) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
                      width: 24,
                      height: 24,
                    ),
                  );
                }

                if (state is FetchCallHistorySuccess) {
                  final docs = state.allDoctorsCalled;
                  final List<PractitionerProfileModel> uniqueDocs =
                      practitionerProfileListModelFromJson(docs.map((e) => jsonEncode(e)).toList().toSet().toList().toString());

                  return ListView.separated(
                    separatorBuilder: (c, cc) {
                      return Divider(
                        height: 0.5,
                        color: Colors.white70,
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: uniqueDocs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final docDetail = uniqueDocs != null ? uniqueDocs[index] : PractitionerProfileModel();

                      return ListTile(
                        title: Text(
                          docDetail.surname == '' || docDetail.surname.isEmpty ? "Dr. Doctor" : docDetail.surname,
                          style: TextStyle(),
                        ),
                        leading: CircleAvatar(
                          radius: 24.w,
                          backgroundImage: AssetImage("assets/images/progile.jpeg"),
                        ),
                        subtitle: Text(
                          docDetail.healthInfo.practitioner ?? " ",
                          style: TextStyle(),
                        ),
                        trailing: SizedBox(
                          width: 100.w,
                          child: Row(
                            children: [
                              //bookmark
                              IconButton(
                                icon: Icon(
                                  MdiIcons.videoOutline,
                                  size: 22.sp,
                                  color: Color(0xff242424),
                                ),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      String durationVal = "5 minutes";

                                      return StatefulBuilder(builder: (context, setState) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
                                          child: Container(
                                            width: 1.sw,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 15.h),

                                                //doc name
                                                Text(
                                                  docDetail.surname,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),

                                                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                                                SizedBox(height: 15.h),
                                                Text(
                                                  'Estimated Call Cost',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                                //cost
                                                Text(
                                                  durationVal == "5 minutes"
                                                      ? 'KES 7.50'
                                                      : durationVal == "10 minutes"
                                                          ? "KES 15.00"
                                                          : durationVal == "15 minutes"
                                                              ? "KES 22.50"
                                                              : "",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),

                                                //drop down
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                  child: DropdownButtonFormField(
                                                    value: durationVal,
                                                    isExpanded: true,
                                                    onTap: () {},
                                                    onChanged: (val) {
                                                      setState(() {
                                                        durationVal = val;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 24.r,
                                                      color: accentColorDark,
                                                    ),
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: accentColorDark,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: accentColorDark,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: accentColorDark,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                                    ),
                                                    elevation: 0,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff707070),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    dropdownColor: Colors.white,
                                                    hint: Text(
                                                      'Select Duration',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Color(0xff707070),
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    items: ["5 minutes", "10 minutes", "15 minutes"]
                                                        .map(
                                                          (e) => DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              e,
                                                              style: TextStyle(),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),

                                                //continue
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                  child: BlocConsumer<CallBalanceCubit, CallBalanceState>(
                                                    listener: (context, state) {},
                                                    builder: (context, state) {
                                                      return MaterialButton(
                                                        onPressed: () async {
                                                          final double amountToUse = durationVal == "5 minutes"
                                                              ? 7.50
                                                              : durationVal == "10 minutes"
                                                                  ? 15.00
                                                                  : durationVal == "15 minutes"
                                                                      ? 22.50
                                                                      : null;
                                                          // await for camera and mic permissions before pu-shing video page
                                                          await Permission.camera.request();
                                                          await Permission.microphone.request();
                                                          // push video page with given channel name
                                                          state is CallBalanceFetchSuccess &&
                                                                  (state.callBalanceModel.amount != null ||
                                                                      double.parse(state.callBalanceModel.amount) <= amountToUse)
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => CallPage(
                                                                      callDuration: int.parse(durationVal.split(" ").first),
                                                                      channelName: 'testchannel1',
                                                                      role: ClientRole.Broadcaster,
                                                                      mutedAudio: false,
                                                                      mutedVideo: false,
                                                                      userID: 5,
                                                                      docID: 12,
                                                                      callBalanceAmount: double.parse(state.callBalanceModel.amount.split(".").first),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => TopUpAccount(),
                                                                  ),
                                                                );
                                                        },
                                                        minWidth: 374.w,
                                                        elevation: 0.0,
                                                        child: Text(
                                                          'Continue',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13.sp,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        highlightElevation: 0.0,
                                                        focusElevation: 0.0,
                                                        disabledElevation: 0.0,
                                                        color: Color(0xff1A5864),
                                                        height: 40.h,
                                                        highlightColor: Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4.r),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),

                                                //show balance
                                                TextButton(
                                                  onPressed: () async {
                                                    //navigate to get credit
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => TopUpAccount(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Check Balance',
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: accentColorDark,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                              ),

                              //call
                              IconButton(
                                icon: Icon(
                                  MdiIcons.phone,
                                  size: 22.sp,
                                  color: Color(0xff242424),
                                ),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      String durationVal = "5 minutes";

                                      return StatefulBuilder(builder: (context, setState) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
                                          child: Container(
                                            width: 1.sw,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 15.h),

                                                //doc name
                                                Text(
                                                  docDetail.surname,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),

                                                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                                                SizedBox(height: 15.h),
                                                Text(
                                                  'Estimated Call Cost',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                                //cost
                                                Text(
                                                  durationVal == "5 minutes"
                                                      ? 'KES 7.50'
                                                      : durationVal == "10 minutes"
                                                          ? "KES 15.00"
                                                          : durationVal == "15 minutes"
                                                              ? "KES 22.50"
                                                              : "",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),

                                                //drop down
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                  child: DropdownButtonFormField(
                                                    value: durationVal,
                                                    isExpanded: true,
                                                    onTap: () {},
                                                    onChanged: (val) {
                                                      setState(() {
                                                        durationVal = val;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 24.r,
                                                      color: accentColorDark,
                                                    ),
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: accentColorDark,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: accentColorDark,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: accentColorDark,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                                                    ),
                                                    elevation: 0,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff707070),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    dropdownColor: Colors.white,
                                                    hint: Text(
                                                      'Select Duration',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Color(0xff707070),
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    items: ["5 minutes", "10 minutes", "15 minutes"]
                                                        .map(
                                                          (e) => DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              e,
                                                              style: TextStyle(),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),

                                                //continue
                                                BlocConsumer<CallBalanceCubit, CallBalanceState>(
                                                  listener: (context, state) {},
                                                  builder: (context, state) {
                                                    return Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                      child: MaterialButton(
                                                        onPressed: () async {
                                                          final double amountToUse = durationVal == "5 minutes"
                                                              ? 7.50
                                                              : durationVal == "10 minutes"
                                                                  ? 15.00
                                                                  : durationVal == "15 minutes"
                                                                      ? 22.50
                                                                      : null;
                                                          // await for camera and mic permissions before pu-shing video page
                                                          await Permission.camera.request();
                                                          await Permission.microphone.request();
                                                          // push video page with given channel name
                                                          state is CallBalanceFetchSuccess &&
                                                                  (state.callBalanceModel.amount != null ||
                                                                      double.parse(state.callBalanceModel.amount) <= amountToUse)
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => CallPage(
                                                                      callDuration: int.parse(durationVal.split(" ").first),
                                                                      channelName: 'testchannel1',
                                                                      role: ClientRole.Broadcaster,
                                                                      mutedAudio: false,
                                                                      mutedVideo: true,
                                                                      userID: 5,
                                                                      docID: 12,
                                                                      callBalanceAmount: double.parse(state.callBalanceModel.amount.split(".").first),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => TopUpAccount(),
                                                                  ),
                                                                );
                                                        },
                                                        minWidth: 374.w,
                                                        elevation: 0.0,
                                                        child: Text(
                                                          'Continue',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13.sp,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        highlightElevation: 0.0,
                                                        focusElevation: 0.0,
                                                        disabledElevation: 0.0,
                                                        color: Color(0xff1A5864),
                                                        height: 40.h,
                                                        highlightColor: Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4.r),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(height: 15.h),

                                                //show balance
                                                TextButton(
                                                  onPressed: () async {
                                                    //navigate to get credit
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => TopUpAccount(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Check Balance',
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: accentColorDark,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (state is FetchCallHistoryFailure) {
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
