import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/screens/practitioners/practitioner_profile_screen.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/verified_tag.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appointments/book_appointment_screen.dart';
import 'filter_practitioners_screen.dart';

class PractitionersListScreen extends StatefulWidget {
  final String practitionersCategory;

  const PractitionersListScreen({
    Key key,
    @required this.practitionersCategory,
  }) : super(key: key);

  @override
  _PractitionersListScreenState createState() => _PractitionersListScreenState();
}

class _PractitionersListScreenState extends State<PractitionersListScreen> {
  String filterByName;
  bool isSortedByCheapest = false;
  bool saveContactVal = false;

  checkIfSorted(ListPractitionersLoaded state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //sort
    bool sortCheapest = prefs.getBool('sortByCheapest');
    sortCheapest == null
        ? null
        : sortCheapest == true
            ? setState(() => isSortedByCheapest = true)
            : null;

    //filter
    String filterCountry = prefs.getString('filterByCountry');

    if (filterCountry != null) {
      state.practitionerProfiles.retainWhere((element) => element.phoneNumber.startsWith(filterCountry));
    }

    if (isSortedByCheapest && state.practitionerProfiles.isNotEmpty)
      state.practitionerProfiles.sort((a, b) => double.parse(a.ratesInfo.onlineBooking.upto1Hour).compareTo(double.parse(b.ratesInfo.onlineBooking.upto1Hour)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7FFFF),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          widget.practitionersCategory,
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
                          await prefs.setString('filterByName', val);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0.w),
                          hintText: "Search for doctor",
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
                    prefs.containsKey('filterByPrice') ? prefs.remove('filterByPrice') : null;
                    prefs.containsKey('filterByDistance') ? prefs.remove('filterByDistance') : null;
                    prefs.containsKey('filterByCountry') ? prefs.remove('filterByCountry') : null;
                    prefs.containsKey('sortByCheapest') ? prefs.remove('sortByCheapest') : null;
                    prefs.containsKey('filterByAvailability') ? prefs.remove('filterByAvailability') : null;
                    prefs.containsKey('sortByNearest') ? prefs.remove('sortByNearest') : null;
                    prefs.containsKey('filterBySpeciality') ? prefs.remove('filterBySpeciality') : null;
                    // test();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FilterPractitionersScreen(
                            practitionerCategory: widget.practitionersCategory,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 20.h),

            //practitioners listing
            BlocBuilder<ListPractitionersCubit, ListPractitionersState>(
              builder: (context, state) {
                if (state is ListPractitionersLoaded) {
                  checkIfSorted(state);

                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filterByName != null
                          ? state.practitionerProfiles.where((element) => (element.surname.toLowerCase().contains(filterByName.toLowerCase()))).length
                          : state.practitionerProfiles.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final PractitionerProfileModel practitionerModel = filterByName != null
                            ? state.practitionerProfiles
                                .where((element) => (element.surname.toLowerCase().contains(filterByName.toLowerCase())))
                                .toList()[index]
                            : state.practitionerProfiles[index];

                        final surname = practitionerModel.surname;
                        final location = practitionerModel.location;
                        final phoneNumber = practitionerModel.phoneNumber;
                        final profileImgUrl = practitionerModel.profileImgUrl;
                        final region = practitionerModel.region;
                        final user = practitionerModel.user;

                        //health info
                        final practitioner = practitionerModel.healthInfo.practitioner;
                        final speciality = practitionerModel.healthInfo.speciality;
                        final affiliatedInstitution = practitionerModel.healthInfo.affiliatedInstitution;
                        final healthInstitution = practitionerModel.healthInfo.healthInstitution;
                        final careType = practitionerModel.healthInfo.careType;

                        //rates info
                        final followUpPerHour = practitionerModel.ratesInfo.followUpVisit.perHour;
                        final followUpPerVisit = practitionerModel.ratesInfo.followUpVisit.perVisit;
                        final inPersonPerHour = practitionerModel.ratesInfo.inPersonBooking.perHour;
                        final inPersonPerVisit = practitionerModel.ratesInfo.inPersonBooking.perVisit;
                        final upto1Hour = practitionerModel.ratesInfo.onlineBooking.upto1Hour;
                        final upto15Mins = practitionerModel.ratesInfo.onlineBooking.upto15Mins;
                        final upto30Mins = practitionerModel.ratesInfo.onlineBooking.upto30Mins;

                        bool isVerified = checkVerification(practitionerModel);

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) {
                                return PractitionerProfileScreen(
                                  isVerified: isVerified,
                                  practitionerModel: practitionerModel,
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
                              tag: "profile-${practitionerModel.user}",
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
                                          backgroundImage: AssetImage("assets/images/progile.jpeg"),
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
                                                surname,
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
                                              BlocBuilder<SavedContactsCubit, SavedContactsState>(
                                                builder: (context, state) {
                                                  if (state is SavedContactsSuccess) {
                                                    final isSaved = state.savedContacts.contains("docIDTestThree" + '${practitionerModel.user.toString()}');
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
                                                        context.read<SavedContactsCubit>()
                                                          ..addRemoveContacts(saveContactVal, "docIDTestThree" + "${practitionerModel.user.toString()}");
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
                                            practitioner ?? 'null',
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
                                                      location + ', ' + region,
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
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              //view profile btn
                                              TextButton(
                                                child: Text(
                                                  'View Profile',
                                                  style: TextStyle(
                                                    color: Color(0xff1A5864),
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h)),
                                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4.w),
                                                    side: BorderSide(
                                                      color: Color(0xff1A5864),
                                                      width: 1.w,
                                                    ),
                                                  )),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (BuildContext context) {
                                                      return PractitionerProfileScreen(
                                                        isVerified: isVerified,
                                                        practitionerModel: practitionerModel,
                                                      );
                                                    }),
                                                  );
                                                },
                                              ),

                                              Spacer(),

                                              //book appointment btn
                                              TextButton(
                                                child: Text(
                                                  'Book Appointment',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                                                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h)),
                                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4.w),
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
                                                        practitionerModel: practitionerModel,
                                                      );
                                                    }),
                                                  );
                                                },
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
                      });
                } else if (state is ListPractitionersLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Container(height: 20, color: Colors.red, width: 50);
                }
              },
            ),

            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}

bool checkVerification(PractitionerProfileModel docDetails) {
  final bool isVerified = docDetails.phoneNumber != 'null' &&
      docDetails.surname != '' &&
      docDetails.user != null &&
      docDetails.ratesInfo.followUpVisit.perVisit != null &&
      docDetails.ratesInfo.followUpVisit.perHour != null &&
      docDetails.ratesInfo.inPersonBooking.perVisit != null &&
      docDetails.ratesInfo.inPersonBooking.perHour != null &&
      docDetails.ratesInfo.onlineBooking.upto1Hour != null &&
      docDetails.ratesInfo.onlineBooking.upto30Mins != null &&
      docDetails.ratesInfo.onlineBooking.upto15Mins != null &&
      docDetails.healthInfo.speciality != null &&
      docDetails.healthInfo.practitioner != null &&
      docDetails.healthInfo.healthInstitution != null &&
      docDetails.healthInfo.careType != null &&
      docDetails.healthInfo.affiliatedInstitution != null &&
      docDetails.region != 'null' &&
      docDetails.location != 'null' &&
      docDetails.profileImgUrl != 'null';
  return isVerified;
}
