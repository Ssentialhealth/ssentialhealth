import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide BuildContextX;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/filter_insurance_reviews/filter_insurance_reviews_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/insurance_reviews/insurance_reviews_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/post_insurance_review/post_insurance_review_cubit.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/models/insurance_review_model.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/health_insurance/purchase_insurance_page.dart';
import 'package:pocket_health/screens/health_insurance/sort_insurance_reviews_row.dart';
import 'package:pocket_health/screens/health_insurance/write_insurance_review_dialog.dart';
import 'package:pocket_health/screens/wellness/resource_card.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'insurance_reviews_list.dart';

class InsuranceProfilePage extends StatefulWidget {
  final HealthInsuranceModel insuranceModel;

  const InsuranceProfilePage({
    Key key,
    this.insuranceModel,
  }) : super(key: key);

  @override
  _InsuranceProfilePageState createState() => _InsuranceProfilePageState();
}

class _InsuranceProfilePageState extends State<InsuranceProfilePage> with SingleTickerProviderStateMixin {
  bool filterIsSelected = false;
  TabController _tabController;
  bool saveContactVal = false;
  String durationVal = "5 minutes";
  bool isLoading = false;
  PractitionerProfileModel practitionerModel = PractitionerProfileModel();
  bool isVerified = false;

  List reportCategories = [
    'Spam and Misleading',
    'Violent and Harrasment',
    'Infringes my rights',
    'Sexual Activity',
    'Others',
  ];

  List days = [
    "Monday",
    "Tuesday",
    "Wedneday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void initState() {
    super.initState();
    context.read<InitializeStreamChatCubit>()..loadInitial();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              //profile
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                floating: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                bottom: PreferredSize(
                  preferredSize: Size(1.sw, 174.h),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xC000000),
                          blurRadius: 4.w,
                          spreadRadius: 2.w,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //deets
                        Hero(
                          tag: "insurance-profile-${widget.insuranceModel.id}",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //avi / rating
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //avi
                                    CircleAvatar(
                                      radius: 40.w,
                                      backgroundImage: widget.insuranceModel.profileImgUrl != ""
                                          ? NetworkImage(widget.insuranceModel.profileImgUrl)
                                          : AssetImage("assets/images/progile.jpeg"),
                                    ),

                                    SizedBox(height: 8.h),

                                    //rating bar
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          itemCount: 5,
                                          itemSize: 12.w,
                                          direction: Axis.horizontal,
                                          rating: 3.5,
                                          unratedColor: Colors.orange.shade100,
                                          itemBuilder: (context, index) {
                                            return Icon(
                                              Icons.star,
                                              size: 12.w,
                                              color: Colors.orange,
                                            );
                                          },
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          '4.6/5',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffF06E20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(width: 10.w),

                                //details
                                Expanded(
                                  child: Container(
                                    height: 45.h,
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
                                              widget.insuranceModel.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff242424),
                                              ),
                                            ),
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
                                                  width: 140.w,
                                                  child: Text(
                                                    widget.insuranceModel.location.isEmpty ? " N/A" : widget.insuranceModel.location,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
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
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.directions,
                                                  size: 15.w,
                                                  color: Color(0xff1A5864),
                                                ),
                                                Text(
                                                  ' Get Directions',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0xff1A5864),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        //purchase insurance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //purchase insurance btn

                            Expanded(
                              child: TextButton(
                                child: Text(
                                  'Purchase Insurance',
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PurchaseInsurancePage(insuranceModel: widget.insuranceModel),
                                    ),
                                  );
                                },
                              ),
                            ),

                            SizedBox(width: 10),

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
                                        return TextButton(
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
                                        );
                                      }
                                      if (state is StreamChannelSuccess) {
                                        return TextButton(
                                          child: Icon(
                                            Icons.chat_bubble_outline,
                                            color: accentColorDark,
                                            size: 21.w,
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
                                        );
                                      }
                                      return TextButton(
                                        child: Icon(
                                          Icons.chat_bubble_outline,
                                          color: accentColorDark,
                                          size: 21.w,
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
                                        onPressed: () {
                                          context.read<InitializeStreamChatCubit>().initializeInsuranceChannel(userID, insurance, userCategory, false);
                                        },
                                      );
                                    },
                                  );
                                }
                                return TextButton(
                                  child: Icon(
                                    Icons.chat_bubble_outline,
                                    color: accentColorDark,
                                    size: 21.w,
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
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        //tab switcher
                        TabBar(
                          indicatorColor: accentColorDark,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: false,
                          labelColor: accentColorDark,
                          unselectedLabelColor: Color(0xff777a7e),
                          indicatorPadding: EdgeInsets.zero,
                          onTap: (tabIdx) {
                            if (tabIdx == 2) return context.read<InsuranceReviewsCubit>()..loadInsuranceReviews();
                          },
                          labelPadding: EdgeInsets.zero,
                          labelStyle: TextStyle(
                            color: accentColorDark,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: accentColorDark,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: _tabController,
                          tabs: [
                            SizedBox(
                              height: 28.h,
                              child: Tab(
                                text: '   About   ',
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                              child: Tab(
                                text: '   Rates   ',
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                              child: Tab(
                                text: '   Policy   ',
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                              child: Tab(
                                text: '   Reviews   ',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actionsIconTheme: IconThemeData(),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              //about
              ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                children: [
                  //contacts
                  Container(
                    height: 144.h,
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0x19000000),
                        width: 1.h,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xC000000),
                          blurRadius: 4.w,
                          spreadRadius: 2.w,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contacts', style: sectionTitle),
                        //number
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.call, size: 20.w, color: accentColorDark),
                              SizedBox(width: 15.w),
                              Text(
                                widget.insuranceModel.phoneNumber == '' ? "N/A" : widget.insuranceModel.phoneNumber,
                                style: TextStyle(color: textBlack),
                              ),
                            ],
                          ),
                        ),

                        //email
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.mail, size: 20.w, color: accentColorDark),
                              SizedBox(width: 15.w),
                              Text(
                                widget.insuranceModel.email.isEmpty ? "N/A" : widget.insuranceModel.email,
                                style: TextStyle(color: textBlack),
                              ),
                            ],
                          ),
                        ),

                        //location
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.explore, size: 20.w, color: accentColorDark),
                              SizedBox(width: 15.w),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  widget.insuranceModel.location.isEmpty ? "N/A" : widget.insuranceModel.location,
                                  style: TextStyle(color: textBlack),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),

                  //overview
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0x19000000),
                        width: 1.h,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xC000000),
                          blurRadius: 4.w,
                          spreadRadius: 2.w,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overview', style: sectionTitle),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            widget.insuranceModel.overview,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                ],
              ),

              //rates
              ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0x19000000),
                        width: 1.h,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xC000000),
                          blurRadius: 4.w,
                          spreadRadius: 2.w,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                          child: Text(
                            'Rates',
                            style: sectionTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Consumer(
                    builder: (context, ScopedReader watch, child) {
                      final linksAsyncVal = watch(linksModelProvider);
                      return linksAsyncVal.when(
                        data: (data) {
                          final links = data.where((e) => e.linkName.toLowerCase().contains("-${widget.insuranceModel.name.toLowerCase()}")).toList();
                          if (links.length == 0)
                            return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text("Documents not found for this insurance"),
                              ),
                            );
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: ResourceCard(
                                  link: links[0],
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () {
                          return Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        error: (err, stack) {
                          return Text(
                            'An error occurred. Please try again.',
                            style: TextStyle(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              //policy
              ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0x19000000),
                        width: 1.h,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xC000000),
                          blurRadius: 4.w,
                          spreadRadius: 2.w,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                          child: Text(
                            'Policy Documents',
                            style: sectionTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Consumer(
                    builder: (context, ScopedReader watch, child) {
                      final linksAsyncVal = watch(linksModelProvider);
                      return linksAsyncVal.when(
                        data: (data) {
                          final links = data.where((e) => e.linkName.toLowerCase().contains("-${widget.insuranceModel.name.toLowerCase()}")).toList();
                          if (links.length == 0)
                            return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text("Documents not found for this insurance"),
                              ),
                            );
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: ResourceCard(
                                  link: links[1],
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () {
                          return Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        error: (err, stack) {
                          return Text(
                            'An error occurred. Please try again.',
                            style: TextStyle(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 15.w),
                clipBehavior: Clip.hardEdge,
                physics: ScrollPhysics(),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0x19000000),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xC000000),
                        blurRadius: 4.w,
                        spreadRadius: 2.w,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //title
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sort by:', style: sectionTitle),
                            GestureDetector(
                              onTap: () {
                                context.read<PostInsuranceReviewCubit>()..loadInitial();
                                showDialog(
                                  context: context,
                                  builder: (context) => WriteInsuranceReviewDialog(insurance: widget.insuranceModel),
                                );
                              },
                              child: Text('Write a review', style: sectionTitle),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      //filter chips
                      BlocBuilder<InsuranceReviewsCubit, InsuranceReviewsState>(
                        builder: (context, state) {
                          if (state is LoadInsuranceReviewsLoaded) {
                            final List<InsuranceReviewModel> toSort = state.insuranceReviewModels;
                            return SortInsuranceReviewsRow(toSort: toSort);
                          } else
                            return SortInsuranceReviewsRow();
                        },
                      ),

                      SizedBox(height: 10.h),

                      //reviews
                      BlocBuilder<InsuranceReviewsCubit, InsuranceReviewsState>(
                        builder: (context, reviewsState) {
                          if (reviewsState is LoadInsuranceReviewsLoaded) {
                            return BlocBuilder<FilterInsuranceReviewsCubit, FilterInsuranceReviewsState>(
                              builder: (context, state) {
                                //recent
                                if (state is RecentlyRatedLoaded) {
                                  return InsuranceReviewsList(reviewsState.insuranceReviewModels);
                                }

                                //highest
                                if (state is HighestRatedLoaded) {
                                  final sortedByHighestRated = state.sortedByHighestRated;
                                  return InsuranceReviewsList(sortedByHighestRated);
                                }

                                //lowest
                                if (state is LowestRatedLoaded) {
                                  final sortedByLowestRated = state.sortedByLowestRated;
                                  return InsuranceReviewsList(sortedByLowestRated);
                                }

                                //loading
                                if (state is FilterReviewsLoading) {
                                  return SizedBox(
                                    height: 20.w,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.tealAccent,
                                      color: accentColorDark,
                                    ),
                                  );
                                }

                                //failure
                                if (state is FilterReviewsFailure) {
                                  return Container();
                                }

                                return Container();
                              },
                            );
                          }

                          if (reviewsState is LoadInsuranceReviewsFailure) {
                            return Container();
                          }

                          if (reviewsState is LoadInsuranceReviewsLoading) {
                            return SizedBox(
                              height: 20.w,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.tealAccent,
                                color: accentColorDark,
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
