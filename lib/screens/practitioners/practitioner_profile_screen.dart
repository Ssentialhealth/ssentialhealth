import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/filter_reviews/filter_reviews_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/post_review/post_review_cubit.dart';
import 'package:pocket_health/bloc/reviews/reviews_cubit.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/practitioners/reviews_list.dart';
import 'package:pocket_health/screens/practitioners/sort_reviews_row.dart';
import 'package:pocket_health/screens/practitioners/write_review_dialog.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/verified_tag.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'book_appointment_screen.dart';

class PractitionerProfileScreen extends StatefulWidget {
  final PractitionerProfileModel practitionerModel;
  final isVerified;

  const PractitionerProfileScreen({Key key, this.practitionerModel, this.isVerified}) : super(key: key);

  @override
  _PractitionerProfileScreenState createState() => _PractitionerProfileScreenState();
}

class _PractitionerProfileScreenState extends State<PractitionerProfileScreen> with SingleTickerProviderStateMixin {
  bool filterIsSelected = false;
  List reportCategories = [
    'Spam and Misleading',
    'Violent and Harrasment',
    'Infringes my rights',
    'Sexual Activity',
    'Others',
  ];

  //tab bar
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<InitializeStreamChatCubit>()..loadInitial(); //test

    _tabController = TabController(length: 3, vsync: this);
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
                          tag: "profile-${widget.practitionerModel.user}",
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
                                      backgroundImage: AssetImage("assets/images/progile.jpeg"),
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
                                    height: 65.h,
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
                                              widget.practitionerModel.surname,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff242424),
                                              ),
                                            ),

                                            SizedBox(width: 10.w),

                                            //verified
                                            widget.isVerified ? VerifiedTag() : Container(),
                                          ],
                                        ),

                                        //speciality
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            widget.practitionerModel.healthInfo.practitioner ?? 'null',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Color(0xff242424),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                                                    widget.practitionerModel.location + ', ' + widget.practitionerModel.region,
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

                        //view profile btn / chat / call
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //book appointment btn
                            TextButton(
                              child: Text(
                                'Book Appointment',
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
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return BookAppointmentScreen(
                                      practitionerModel: widget.practitionerModel,
                                    );
                                  }),
                                );
                              },
                            ),
                            //chat
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoginLoaded) {
                                  final userID = state.loginModel.user.fullNames.split(' ').first + state.loginModel.user.fullNames.split(' ').last;
                                  // final docID = widget.practitionerModel.surname.split(' ').first;
                                  final docID = 'DrTest' + '${Random().nextInt(40).toString()}';

                                  return BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
                                    listener: (context, state) {
                                      if (state is StreamChannelSuccess) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              print('navigated');
                                              return StreamChat(
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
                                          context.read<InitializeStreamChatCubit>().initializeChannel(docID, userID);
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
                                  onPressed: () async {},
                                );
                              },
                            ),
                            //call
                            TextButton(
                              child: Icon(
                                Icons.call,
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
                            if (tabIdx == 1) return context.read<ReviewsCubit>()..loadReviews();
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
                                text: '   Reviews   ',
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                              child: Tab(
                                text: '   Report   ',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actionsIconTheme: IconThemeData(),
                actions: [
                  //bookmark
                  IconButton(
                    icon: Icon(
                      Icons.bookmark_outline,
                      size: 22.sp,
                      color: Color(0xff242424),
                    ),
                    onPressed: () {},
                  ),

                  //share
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.share,
                        size: 22.sp,
                        color: Color(0xff242424),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
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
                                '+254 710 122 111 / 020 011 112',
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
                                'johndoe@email.com',
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
                              Text(
                                'Nairobi, Kenya',
                                style: TextStyle(color: textBlack),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  //
                  // //overview
                  // Container(
                  //   height: 144.h,
                  //   clipBehavior: Clip.hardEdge,
                  //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     border: Border.all(
                  //       color: Color(0x19000000),
                  //       width: 1.h,
                  //     ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Color(0xC000000),
                  //         blurRadius: 4.w,
                  //         spreadRadius: 2.w,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text('Overview', style: sectionTitle),
                  //       SizedBox(height: 8.h),
                  //       Padding(
                  //         padding: EdgeInsets.only(left: 5.w),
                  //         child: Text(
                  //           'Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisnAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [',
                  //           maxLines: 5,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //             color: textBlack,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 10.h),

                  //rates title
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rates",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 74.w,
                          height: 28.h,
                          child: DropdownButtonFormField(
                            onTap: () {},
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: accentColorDark,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 1,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 18.w,
                              color: accentColorDark,
                            ),
                            dropdownColor: accentColorLight,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8.w),
                              enabledBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: accentColorDark,
                                ),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                            ),
                            onChanged: (val) {},
                            value: "KSH",
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                value: "Test",
                                child: Text(
                                  'USD',
                                  style: TextStyle(fontSize: 14.sp, color: accentColorDark, fontWeight: FontWeight.w600),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "KSH",
                                child: Text(
                                  'KSH',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: accentColorDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // online booking rates
                  Container(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Color(0x19000000),
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Online Rates', style: sectionTitle),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 382.w,
                              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: Color(0xffEAFCF6),
                                borderRadius: BorderRadius.circular(5.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xC000000),
                                    blurRadius: 4.w,
                                    spreadRadius: 2.w,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1 min - 15 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "15 mins - 30 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "30 mins - 60 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  //inPerson Booking rates
                  Container(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Online Rates', style: sectionTitle),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 382.w,
                              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: Color(0xffEAFCF6),
                                borderRadius: BorderRadius.circular(5.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xC000000),
                                    blurRadius: 4.w,
                                    spreadRadius: 2.w,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1 min - 15 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "15 mins - 30 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "30 mins - 60 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  //follow up visit rates
                  Container(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Online Rates', style: sectionTitle),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 382.w,
                              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: Color(0xffEAFCF6),
                                borderRadius: BorderRadius.circular(5.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xC000000),
                                    blurRadius: 4.w,
                                    spreadRadius: 2.w,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1 min - 15 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "15 mins - 30 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "30 mins - 60 mins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textBlack,
                                        ),
                                      ),
                                      Text("Ksh 2,500", style: sectionTitle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //reviews
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
                                context.read<PostReviewCubit>()..loadInitial();
                                showDialog(
                                  context: context,
                                  builder: (context) => WriteReviewDialog(),
                                );
                              },
                              child: Text('Write a review', style: sectionTitle),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      //filter chips
                      BlocBuilder<ReviewsCubit, ReviewsState>(
                        builder: (context, state) {
                          if (state is LoadReviewsLoaded) {
                            final List<ReviewModel> toSort = state.reviewModels;
                            return SortReviewsRow(toSort: toSort);
                          } else
                            return SortReviewsRow();
                        },
                      ),

                      SizedBox(height: 10.h),

                      //reviews
                      BlocBuilder<ReviewsCubit, ReviewsState>(
                        builder: (context, reviewsState) {
                          if (reviewsState is LoadReviewsLoaded) {
                            return BlocBuilder<FilterReviewsCubit, FilterReviewsState>(
                              builder: (context, state) {
                                //recent
                                if (state is RecentlyRatedLoaded) {
                                  return ReviewsList(reviewsState.reviewModels);
                                }

                                //highest
                                if (state is HighestRatedLoaded) {
                                  final sortedByHighestRated = state.sortedByHighestRated;
                                  return ReviewsList(sortedByHighestRated);
                                }

                                //lowest
                                if (state is LowestRatedLoaded) {
                                  final sortedByLowestRated = state.sortedByLowestRated;
                                  return ReviewsList(sortedByLowestRated);
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
                                  return Container(
                                    height: 100,
                                    color: Colors.red,
                                  );
                                }

                                return Container(
                                  height: 100,
                                  color: Colors.pink,
                                );
                              },
                            );
                          }
                          if (reviewsState is LoadReviewsFailure) {
                            return Container(
                              height: 100,
                              color: Colors.red,
                            );
                          }

                          if (reviewsState is LoadReviewsLoading) {
                            return SizedBox(
                              height: 20.w,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.tealAccent,
                                color: accentColorDark,
                              ),
                            );
                          }

                          return Container(
                            height: 100,
                            color: Colors.yellow,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              //report
              ListView(
                padding: EdgeInsets.symmetric(vertical: 15.w),
                children: [
                  Container(
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
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 15.w),
                          child: Text(
                            "Let the admins know what's wrong with the user. No one else will see your name or the content of this report.",
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff6A6969),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(reportCategories.length, (index) {
                    return Column(
                      children: [
                        //tile

                        ListTile(
                          isThreeLine: false,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Color(0xff00FFFF),
                          ),
                          title: Text(
                            reportCategories[index],
                            style: listTileTitleStyle,
                          ),
                          onTap: () {},
                        ),

                        //divider
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Divider(
                            height: 0,
                            thickness: 0.0,
                            color: Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
