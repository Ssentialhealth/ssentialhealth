import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/list_facilities/list_facilities_cubit.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/bloc/saved_facility_contacts/saved_facility_contacts_cubit.dart';
import 'package:pocket_health/screens/doctor_consult/saved/saved_list.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'call/calls_list.dart';
import 'chat/channels_list.dart';

class DoctorConsult extends StatefulWidget {
  @override
  _DoctorConsultState createState() => _DoctorConsultState();
}

class _DoctorConsultState extends State<DoctorConsult> with SingleTickerProviderStateMixin {
  //tab bar
  TabController _tabController;
  bool agreeConsult = false;
  bool isChecking = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        agreeConsult = prefs.getBool('isAgreedConsult');
        isChecking = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isChecking
          ? Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: accentColor,
                elevation: 0.0,
                title: Text(
                  'Doctor Consult',
                  style: appBarStyle.copyWith(fontSize: 18.sp),
                ),
              ),
              body: Column(
                children: [],
              ),
            )
          : agreeConsult != true
              ? Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0.0,
                    backgroundColor: accentColor,
                    centerTitle: true,
                    title: Text(
                      'Doctor Consult',
                      style: appBarStyle.copyWith(fontSize: 18.sp),
                    ),
                  ),
                  body: Column(
                    children: [
                      SizedBox(height: 30.h),

                      Text(
                        'Call & Consult Practitioners\non Ssential App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 30.h),

                      //banner 1
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                              height: 30.w,
                              child: Image(
                                image: AssetImage("assets/images/icons/online_payment.png"),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            SizedBox(
                              width: 300,
                              child: RichText(
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                text: TextSpan(
                                  text: "Enjoy affordable quality call consultation.",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0xff515050),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " First 3 consultations free.",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff515050),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30.h),

                      //banner 2
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                              height: 30.w,
                              child: Image(
                                image: AssetImage("assets/images/icons/contacts.png"),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            SizedBox(
                              width: 300,
                              child: RichText(
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                text: TextSpan(
                                  text: "Chat is free ",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0xff515050),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " within Ssential",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff515050),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 60.h),

                      //continue
                      MaterialButton(
                        color: accentColorDark,
                        elevation: 0.0,
                        height: 40.0.h,
                        minWidth: 376.w,
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          final newBool = await prefs.setBool('isAgreedConsult', true);
                          setState(() {
                            agreeConsult = newBool;
                          });
                        },
                      ),
                    ],
                  ),
                )
              : Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: accentColor,
                          elevation: 0.0,
                          title: Text(
                            'Doctor Consult',
                            style: appBarStyle.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: PersistentHeaderDelegate(
                            widget: Theme(
                              data: ThemeData(
                                highlightColor: Colors.transparent,
                                splashColor: accentColorDark,
                                focusColor: Colors.transparent,
                              ),
                              child: TabBar(
                                isScrollable: false,
                                onTap: (idx) async {
                                  if (idx == 2) {
	                                  context.read<SavedContactsCubit>()..fetchContacts();
                                    context.read<SavedFacilityContactsCubit>()..fetchContacts();
                                    context.read<ListPractitionersCubit>()..listPractitioners();
                                    context.read<ListFacilitiesCubit>()..listFacilities("");
                                  }
                                },
                                overlayColor: MaterialStateProperty.all(Colors.white),
                                indicatorColor: accentColorDark,
                                labelPadding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: accentColorDark,
                                unselectedLabelColor: Colors.black45,
                                controller: _tabController,
                                labelStyle: TextStyle(
                                  color: accentColorDark,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                unselectedLabelStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                tabs: [
                                  Tab(
                                    iconMargin: EdgeInsets.only(bottom: 6),
                                    text: ' Calls ',
                                    icon: Icon(
                                      Icons.call,
                                      size: 20,
                                    ),
                                  ),
                                  Tab(
                                    iconMargin: EdgeInsets.only(bottom: 6),
                                    text: ' Chats ',
                                    icon: Icon(
                                      Icons.chat,
                                      size: 20,
                                    ),
                                  ),
                                  Tab(
                                    iconMargin: EdgeInsets.only(bottom: 6),
                                    text: ' Saved ',
                                    icon: Icon(
                                      Icons.contact_phone,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoaded) {
                              return CallsList(loginModel: state.loginModel);
                            }
                            if (state is LoginError) {
                              return Container();
                            }
                            return Container();
                          },
                        ),
                        ChannelsList(),
                        SavedList(),
                      ],
                    ),
                  ),
                  // bottomNavigationBar: BottomNavigationBar(),
                ),
    );
  }
}

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeaderDelegate({this.widget});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: 56.0,
      child: Card(
        margin: EdgeInsets.all(0),
        color: accentColor,
        elevation: 0.0,
        child: Center(child: widget),
      ),
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
