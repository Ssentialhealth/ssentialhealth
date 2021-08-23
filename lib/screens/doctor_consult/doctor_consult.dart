import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/screens/doctor_consult/saved/saved_list.dart';
import 'package:pocket_health/screens/practitioners/practitioners_categories_screen.dart';
import 'package:pocket_health/utils/constants.dart';

import 'call/calls_list.dart';
import 'chat/channels_list.dart';

class DoctorConsult extends StatefulWidget {
  @override
  _DoctorConsultState createState() => _DoctorConsultState();
}

class _DoctorConsultState extends State<DoctorConsult> with SingleTickerProviderStateMixin {
  //tab bar
  TabController _tabController;

  @override
  void initState() {
    super.initState();
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
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: accentColor,
                // centerTitle: true,
                title: Text(
                  'Doctor Consult',
                  style: appBarStyle.copyWith(fontSize: 18.sp),
                ),
                actions: [
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return IconButton(
                        icon: Icon(
                          Icons.add_comment,
                          color: accentColorDark,
                        ),
                        onPressed: state is LoginLoaded && state.loginModel.user.userCategory == 'individual'
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PractitionersCategoriesScreen();
                                    },
                                  ),
                                );
                              }
                            : () {
                                ScaffoldMessenger.of(context)
                                  ..clearSnackBars()
                                  ..showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Color(0xff163C4D),
                                      duration: Duration(milliseconds: 6000),
                                      content: Text(
                                        'This feature is only available to users registered as individuals!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                              },
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      color: accentColorDark,
                    ),
                  ),
                ],
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
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // prefs.remove('savedd');
                          context.read<SavedContactsCubit>()..fetchContacts();
                          context.read<ListPractitionersCubit>()..listPractitioners();
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
