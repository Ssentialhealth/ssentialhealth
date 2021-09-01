import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'call_page.dart';
import 'top_up_account.dart';

class InitCallDialog extends StatefulWidget {
  final String from;
  final bool videoMuted;
  final User streamDocDetail;
  final PractitionerProfileModel docDetail;
  final bool isVerified;

  InitCallDialog({
    Key key,
    this.from,
    this.videoMuted,
    this.docDetail,
    this.streamDocDetail,
    this.isVerified,
  }) : super(key: key);

  @override
  _InitCallDialogState createState() => _InitCallDialogState();
}

class _InitCallDialogState extends State<InitCallDialog> {
  bool showBalance = false;

  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
    context.read<CallBalanceCubit>()..getCallBalance(5);
  }

  String durationVal = "5 minutes";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
      child: Container(
        width: 1.sw,
        child: BlocConsumer<CallBalanceCubit, CallBalanceState>(
          listener: (context, state) {},
          builder: (context, balanceState) {
            return BlocBuilder<FetchCallHistoryCubit, FetchCallHistoryState>(
              builder: (context, historyState) {
                if (balanceState is CallBalanceFetchSuccess && historyState is FetchCallHistorySuccess) {
                  final int balanceInKES = int.parse(balanceState.callBalanceModel.amount.split('.').first);

                  final streamDocID = widget.from == "chat" ? widget.streamDocDetail.id.replaceAll("docIDTestTwo", "") : "";
                  final docID = widget.from == "chat" ? int.parse(streamDocID) : widget.docDetail.user;
                  final int hourlyRate = int.parse(widget.docDetail.ratesInfo.onlineBooking.upto1Hour.split('.').first);
                  final int docRatePerMin = hourlyRate ~/ 60;

                  final double amountToUse = durationVal == "5 minutes"
                      ? (5 * docRatePerMin).toDouble()
                      : durationVal == "10 minutes"
                          ? (10 * docRatePerMin).toDouble()
                          : durationVal == "15 minutes"
                              ? (15 * docRatePerMin).toDouble()
                              : durationVal == "30 minutes"
                                  ? (30 * docRatePerMin).toDouble()
                                  : durationVal == "45 minutes"
                                      ? (45 * docRatePerMin).toDouble()
                                      : durationVal == "60 minutes"
                                          ? (60 * docRatePerMin).toDouble()
                                          : null;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15.h),

                      //doc name
                      Text(
                        widget.from == "chat" ? widget.streamDocDetail.extraData["name"] : widget.docDetail.surname,
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
                        "KES " + "$amountToUse",
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
                          items: ["5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "60 minutes", ""]
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: MaterialButton(
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
                          onPressed: () async {
                            await Permission.camera.request();
                            await Permission.microphone.request();

                            (double.parse(balanceState.callBalanceModel.amount) >= amountToUse)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CallPage(
                                        callDuration: int.parse(durationVal.split(" ").first),
                                        channelName: 'testchannel1',
                                        role: ClientRole.Broadcaster,
                                        mutedAudio: false,
                                        mutedVideo: widget.videoMuted,
                                        userID: 5,
                                        docID: docID,
                                        ratePerMin: docRatePerMin,
                                        callBalanceAmount: double.parse(balanceState.callBalanceModel.amount.split(".").first),
                                        doctorsCalled: historyState.allDoctorsCalled,
                                        isVerified: widget.from == "chat"
                                            ? widget.streamDocDetail.extraData["isVerified"] == "true"
                                                ? true
                                                : false
                                            : widget.isVerified,
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
                        ),
                      ),

                      SizedBox(height: 15.h),

                      //show balance
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            showBalance = !showBalance;
                          });
                        },
                        child: Text(
                          showBalance ? "Hide Balance" : 'Show Balance',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: accentColorDark,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      showBalance
                          ? Text(
                              "KES " + "$balanceInKES",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.orange,
                              ),
                            )
                          : Text(
                              "",
                              style: TextStyle(),
                            ),

                      SizedBox(height: 15.h),
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15.h),

                    //doc name
                    Text(
                      widget.from == "chat" ? widget.streamDocDetail.extraData["name"] : widget.docDetail.surname,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 15.h),

                    SizedBox(
                      height: 24.w,
                      width: 24.w,
                      child: CircularProgressIndicator(),
                    ),

                    SizedBox(height: 15.h),

                    Text(
                      '  Please wait...',
                      style: TextStyle(
                        color: accentColorDark,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 45.h),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
