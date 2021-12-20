import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PurchaseInsurancePage extends StatefulWidget {
  final HealthInsuranceModel insuranceModel;
  const PurchaseInsurancePage({
    Key key,
    this.insuranceModel,
  }) : super(key: key);

  @override
  _PurchaseInsurancePageState createState() => _PurchaseInsurancePageState();
}

class _PurchaseInsurancePageState extends State<PurchaseInsurancePage> {
  @override
  void initState() {
    super.initState();
    context.read<InitializeStreamChatCubit>()..loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: accentColor,
        title: Text(
          'Purchase Insurance',
          style: appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //banner
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: 110.h,
                  width: 1.sw,
                ),
                Container(
                  width: 1.sw,
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/practitioners_banner.png'),
                  ),
                ),
              ],
            ),
            //text

            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "a) Contact insurance or insurance agent through chat or call to understand and clarify any further questions you may have on the insurance. Understand the terms of payment and insurance conditions before purchase.\n\nb) On satisfactorily understanding the terms of the insurance and the required pre-insurance, the insurance or agent sends an online referral to you or their chosen provider.\n\nc) If health examination or tests are required as a pre-condition, you will go to the designated provider to have these done.\n\nd) Your health exam findings and results may be shared in app or mailed to you and your potential insurer.\n\ne) The insurance or agent will contact you to discuss and offer final details on the insurance contract.\n\nf) On agreeing, you will pay the premium to the insurer through thisplatform and submit the electronically signed copy of the insurancecontract to the insurance or agent.\n\ng) Your insurance will begin as per terms accorded.\n\nh) Subsequent payments will be through the platform as dictated by the insurance contract.\n\n ",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),

            //proceeed
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoaded) {
                  final userID = state.loginModel.user.fullNames.split(' ').last;
                  final insurance = widget.insuranceModel;
                  final userCategory = state.loginModel.user.userCategory;

                  return BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
                    listener: (context, state) {
                      if (state is StreamChannelSuccess) {
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
                                  child: ChannelPage(),
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
                      if (state is StreamChannelLoading) {
                        return Expanded(
                          child: TextButton(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: accentColorDark,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: MaterialStateProperty.all(Size(0, 0)),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.w),
                                side: BorderSide(
                                  color: accentColorDark,
                                  width: 1.w,
                                ),
                              )),
                            ),
                            onPressed: () {},
                          ),
                        );
                      }
                      if (state is StreamChannelSuccess) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  child: Text(
                                    'Proceed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                                    minimumSize: MaterialStateProperty.all(Size(0, 0)),
                                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.w),
                                      side: BorderSide(
                                        color: Color(0xff1A5864),
                                        width: 1.w,
                                      ),
                                    )),
                                  ),
                                  onPressed: () {
                                    context.read<InitializeStreamChatCubit>().initializeInsuranceChannel(userID, insurance, userCategory, false);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                child: Text(
                                  'Proceed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h)),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.w),
                                    side: BorderSide(
                                      color: Color(0xff1A5864),
                                      width: 1.w,
                                    ),
                                  )),
                                ),
                                onPressed: () {
                                  context.read<InitializeStreamChatCubit>().initializeInsuranceChannel(userID, insurance, userCategory, false);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                            minimumSize: MaterialStateProperty.all(Size(0, 0)),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w),
                              side: BorderSide(
                                color: Color(0xff1A5864),
                                width: 1.w,
                              ),
                            )),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
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
