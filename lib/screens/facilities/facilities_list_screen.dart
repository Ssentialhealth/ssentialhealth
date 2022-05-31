import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/list_facilities/list_facilities_cubit.dart';
import 'package:pocket_health/bloc/list_facility_open_hours/list_facility_open_hours_cubit.dart';
import 'package:pocket_health/bloc/saved_facility_contacts/saved_facility_contacts_cubit.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/verified_tag.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'facility_profile_screen.dart';
import 'filter_facilities_screen.dart';

class FacilitiesListScreen extends StatefulWidget {
  final String facilitiesCategory;

  const FacilitiesListScreen({
    Key key,
    @required this.facilitiesCategory,
  }) : super(key: key);

  @override
  _FacilitiesListScreenState createState() => _FacilitiesListScreenState();
}

class _FacilitiesListScreenState extends State<FacilitiesListScreen> {
  String filterByName;
  bool isSortedByCheapest = false;
  bool saveContactVal = false;

  @override
  Widget build(BuildContext context) {
    print('--------|category|--------|value -> ${widget.facilitiesCategory.toString()}');

    return Scaffold(
      backgroundColor: Color(0xffE7FFFF),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          widget.facilitiesCategory,
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          children: [
            //search & filter
            Row(
              children: [
                //search bar
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: SizedBox(
                      height: 40.h,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        onChanged: (val) async {
                          setState(() {
                            filterByName = val.toLowerCase();
                          });
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('filterFacilitiesByName', val);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0.w),
                          hintText: "Search for ${widget.facilitiesCategory}",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //filter
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  focusElevation: 0.0,
                  disabledElevation: 0.0,
                  color: Color(0xff1A5864),
                  height: 40.h,
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.filterMenu,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.containsKey('filterFacilityByPrice') ? prefs.remove('filterFacilityByPrice') : null;
                    prefs.containsKey('filterFacilityByDistance') ? prefs.remove('filterFacilityByDistance') : null;
                    prefs.containsKey('filterFacilityByCountry') ? prefs.remove('filterFacilityByCountry') : null;
                    prefs.containsKey('sortFacilityByCheapest') ? prefs.remove('sortFacilityByCheapest') : null;
                    prefs.containsKey('filterFacilityByAvailability') ? prefs.remove('filterFacilityByAvailability') : null;
                    prefs.containsKey('sortFacilityByNearest') ? prefs.remove('sortFacilityByNearest') : null;
                    prefs.containsKey('filterFacilityBySpeciality') ? prefs.remove('filterFacilityBySpeciality') : null;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FilterFacilitiesScreen(
                            facilitiesCategory: widget.facilitiesCategory,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 20.h),

            //facilities listing
            BlocBuilder<ListFacilitiesCubit, ListFacilitiesState>(
              builder: (context, state) {
                if (state is ListFacilitiesLoading) {
                  return Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ListFacilitiesSuccess) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filterByName != null
                        ? state.facilityProfiles.where((element) => (element.facilityName.toLowerCase().contains(filterByName.toLowerCase()))).length
                        : state.facilityProfiles.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final FacilityProfileModel facilityProfileModel = filterByName != null
                          ? state.facilityProfiles.where((element) => (element.facilityName.toLowerCase().contains(filterByName.toLowerCase()))).toList()[index]
                          : state.facilityProfiles[index];
                      final facilityName = facilityProfileModel.facilityName;
                      final facilityLocation = facilityProfileModel.location;
                      final facilityProfileUrl = facilityProfileModel.profileImgUrl;
                      final facilityCategory = facilityProfileModel.facilityType;
                      bool isVerified = checkFacilityVerification(facilityProfileModel);

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return FacilityProfileScreen(
                                isVerified: isVerified,
                                facilityProfileModel: facilityProfileModel,
                              );
                            }),
                          );
                        },
                        child: Container(
                          height: 144.w,
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
                            tag: "facility-profile-${facilityProfileModel.id}",
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
                                        backgroundImage: facilityProfileUrl != "" ? NetworkImage(facilityProfileUrl) : AssetImage("assets/images/progile.jpeg"),
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
                                              facilityName,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Color(0xff242424),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),

                                            //verified
                                            isVerified ? VerifiedTag() : Container(),

                                            Spacer(),

                                            //bookmark
                                            BlocBuilder<SavedFacilityContactsCubit, SavedFacilityContactsState>(
                                              builder: (context, state) {
                                                if (state is SavedFacilityContactsSuccess) {
                                                  final isSaved =
                                                      state.savedFacilityContacts.contains("facilityIDTestFive" + '${facilityProfileModel.id.toString()}');

                                                  return GestureDetector(
                                                    child: Icon(
                                                      isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                                      size: 20.w,
                                                      color: isSaved ? Color(0xff0e0e0e) : Color(0xff242424),
                                                    ),
                                                    onTap: () async {
                                                      setState(() {
                                                        saveContactVal = !isSaved;
                                                      });
                                                      context.read<SavedFacilityContactsCubit>()
                                                        ..addRemoveContacts(saveContactVal, "facilityIDTestFive" + "${facilityProfileModel.id.toString()}");
                                                    },
                                                  );
                                                }
                                                return Icon(
                                                  Icons.bookmark_outline,
                                                  size: 20.w,
                                                  color: Color(0xff242424),
                                                );
                                              },
                                            ),
                                          ],
                                        ),

                                        //speciality
                                        Text(
                                          facilityCategory ?? 'null',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Color(0xff242424),
                                            fontWeight: FontWeight.w400,
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
                                                  width: 150.w,
                                                  child: Text(
                                                    facilityLocation,
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
                                                    MaterialPageRoute(builder: (BuildContext context) {
                                                      context.read<ListFacilityOpenHoursCubit>()..listOpenHoursById(facilityProfileModel.id);

                                                      return FacilityProfileScreen(
                                                        isVerified: isVerified,
                                                        facilityProfileModel: facilityProfileModel,
                                                      );
                                                    }),
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
                }

                if (state is ListFacilitiesFailure) {
                  return Container(color: Colors.red, height: 100, width: 100);
                }

                return Container();
              },
            ),

            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}

bool checkFacilityVerification(FacilityProfileModel facilityDetails) {
  final bool isVerified = facilityDetails.phoneNumber != 'null' &&
      facilityDetails.facilityName != '' &&
      facilityDetails.id != null &&
      facilityDetails.profileImgUrl != null &&
      facilityDetails.coverImgUrl != null &&
      facilityDetails.overview != null &&
      facilityDetails.facilityType != null &&
      facilityDetails.country != null;
  return isVerified;
}
