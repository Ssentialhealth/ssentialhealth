import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/screens/health_insurance/insurance_agent_profile_page.dart';
import 'package:pocket_health/utils/constants.dart';

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
                                  // state is LoginLoaded && state.loginModel.user.userCategory == 'individual'
                                  //     ? null
                                  //     : SnackBar(
                                  //   behavior: SnackBarBehavior.floating,
                                  //   backgroundColor: Color(0xff163C4D),
                                  //   duration: Duration(milliseconds: 6000),
                                  //   content: Text(
                                  //     'This feature is only available to users registered as individuals!',
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // );
                                },
                              ),
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
                          onTap: (tabIdx) {},
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
                                text: '   Agents   ',
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
                actions: [
                  //bookmark
                  IconButton(
                    icon: Icon(
                      Icons.bookmark_outline,
                      size: 22.sp,
                      color: Color(0xff242424),
                    ),
                    onPressed: () async {},
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

              //agents

              Consumer(
                builder: (context, ScopedReader watch, child) {
                  final agentsModelAsyncVal = watch(insuranceAgentModelProvider(widget.insuranceModel.id));
                  return agentsModelAsyncVal.when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final agent = data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InsuranceAgentProfilePage(agentModel: agent),
                                ),
                              );
                            },
                            child: Container(
                              height: 130.w,
                              clipBehavior: Clip.hardEdge,
                              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                              margin: EdgeInsets.only(bottom: 10.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xC000000),
                                    blurRadius: 4.w,
                                    spreadRadius: 2.w,
                                  ),
                                ],
                              ),
                              child: Hero(
                                tag: "agent-profile-${agent.id}",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //avi / rating
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          //avi
                                          CircleAvatar(
                                            radius: 32.w,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: agent.profileImgUrl == "" || agent.profileImgUrl == null
                                                  ? SizedBox.shrink()
                                                  : Image(
                                                      image: NetworkImage(agent.profileImgUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),

                                          SizedBox(height: 8.h),

                                          //rating
                                          Text(
                                            '4.6/5',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffF06E20),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(width: 20.w),

                                      //details
                                      Expanded(
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
                                                  agent.name,
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    color: Color(0xff242424),
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),

                                                Spacer(),

                                                //bookmark
                                                // BlocBuilder<SavedFacilityContactsCubit, SavedFacilityContactsState>(
                                                //   builder: (context, state) {
                                                //     if (state is SavedFacilityContactsSuccess) {
                                                //       final isSaved = state.savedFacilityContacts.contains("facilityIDTestThree" + '${facilityProfileModel.id.toString()}');
                                                //
                                                //       return GestureDetector(
                                                //         child: Icon(
                                                //           isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                                //           size: 20.w,
                                                //           color: isSaved ? Color(0xff0e0e0e) : Color(0xff242424),
                                                //         ),
                                                //         onTap: () async {
                                                //           setState(() {
                                                //             saveContactVal = !isSaved;
                                                //           });
                                                //           context.read<SavedFacilityContactsCubit>()
                                                //             ..addRemoveContacts(saveContactVal, "facilityIDTestThree" + "${facilityProfileModel.id.toString()}");
                                                //         },
                                                //       );
                                                //     }
                                                //     return Icon(
                                                //       Icons.bookmark_outline,
                                                //       size: 20.w,
                                                //       color: Color(0xff242424),
                                                //     );
                                                //   },
                                                // ),
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
                                                      width: 150.w,
                                                      child: Text(
                                                        agent.location ?? "N/A",
                                                        overflow: TextOverflow.ellipsis,
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
                                                Text(
                                                  'Get Directions',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0xff1A5864),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 4.h),

                                            //view profile btn / book appointment btn
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: RawMaterialButton(
                                                    elevation: 0.0,
                                                    fillColor: Colors.white,
                                                    padding: EdgeInsets.zero,
                                                    shape: ContinuousRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      side: BorderSide(color: accentColorDark),
                                                    ),
                                                    child: Text(
                                                      'View Profile',
                                                      style: TextStyle(
                                                        color: Color(0xff1A5864),
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) => InsuranceAgentProfilePage(agentModel: agent),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => Center(
                      child: Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, stack) => Text(
                      "err",
                      style: TextStyle(),
                    ),
                  );
                },
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
                              onTap: () {},
                              child: Text('Write a review', style: sectionTitle),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      //filter chips
                      // BlocBuilder<FacilityReviewsCubit, FacilityReviewsState>(
                      //   builder: (context, state) {
                      //     if (state is LoadFacilityReviewsLoaded) {
                      //       final List<FacilityReviewModel> toSort = state.facilityReviewModels;
                      //       return SortFacilityReviewsRow(toSort: toSort);
                      //     } else
                      //       return SortFacilityReviewsRow();
                      //   },
                      // ),

                      SizedBox(height: 10.h),

                      //reviews
                      // BlocBuilder<FacilityReviewsCubit, FacilityReviewsState>(
                      //   builder: (context, reviewsState) {
                      //     if (reviewsState is LoadFacilityReviewsLoaded) {
                      //       return BlocBuilder<FilterFacilityReviewsCubit, FilterFacilityReviewsState>(
                      //         builder: (context, state) {
                      //           //recent
                      //           if (state is RecentlyRatedLoaded) {
                      //             return FacilityReviewsList(reviewsState.facilityReviewModels);
                      //           }
                      //
                      //           //highest
                      //           if (state is HighestRatedLoaded) {
                      //             final sortedByHighestRated = state.sortedByHighestRated;
                      //             return FacilityReviewsList(sortedByHighestRated);
                      //           }
                      //
                      //           //lowest
                      //           if (state is LowestRatedLoaded) {
                      //             final sortedByLowestRated = state.sortedByLowestRated;
                      //             return FacilityReviewsList(sortedByLowestRated);
                      //           }
                      //
                      //           //loading
                      //           if (state is FilterReviewsLoading) {
                      //             return SizedBox(
                      //               height: 20.w,
                      //               width: 20.w,
                      //               child: CircularProgressIndicator(
                      //                 backgroundColor: Colors.tealAccent,
                      //                 color: accentColorDark,
                      //               ),
                      //             );
                      //           }
                      //
                      //           //failure
                      //           if (state is FilterReviewsFailure) {
                      //             return Container(
                      //               height: 100,
                      //               color: Colors.red,
                      //             );
                      //           }
                      //
                      //           return Container(
                      //             height: 100,
                      //             color: Colors.pink,
                      //           );
                      //         },
                      //       );
                      //     }
                      //     if (reviewsState is LoadFacilityReviewsFailure) {
                      //       return Container(
                      //         height: 100,
                      //         color: Colors.red,
                      //       );
                      //     }
                      //
                      //     if (reviewsState is LoadFacilityReviewsLoading) {
                      //       return SizedBox(
                      //         height: 20.w,
                      //         width: 20.w,
                      //         child: CircularProgressIndicator(
                      //           backgroundColor: Colors.tealAccent,
                      //           color: accentColorDark,
                      //         ),
                      //       );
                      //     }
                      //
                      //     return Container(
                      //       height: 100,
                      //       color: Colors.yellow,
                      //     );
                      //   },
                      // ),
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
