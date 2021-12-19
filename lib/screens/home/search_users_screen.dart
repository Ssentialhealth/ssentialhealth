import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/all_users_model.dart';
import 'package:pocket_health/utils/constants.dart';

class SearchUsersScreen extends StatefulWidget {
  final bool fromFAB;
  const SearchUsersScreen({Key key, this.fromFAB}) : super(key: key);

  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  String searchedByName = '';

  @override
  Widget build(BuildContext context) {
    print("searchedByName $searchedByName");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Search User",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //search & filter
          Row(
            children: [
              //search bar
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: SizedBox(
                    height: 40.h,
                    child: TextFormField(
                      cursorColor: Colors.grey,
                      onChanged: (val) async {
                        setState(() {
                          searchedByName = val.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.all(10.0.w),
                        hintText: "Search for user",
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
              // MaterialButton(
              //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              //   elevation: 0.0,
              //   highlightElevation: 0.0,
              //   focusElevation: 0.0,
              //   disabledElevation: 0.0,
              //   color: Color(0xff1A5864),
              //   height: 40.h,
              //   highlightColor: Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(4.w),
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(
              //         MdiIcons.filterMenu,
              //         color: Colors.white,
              //         size: 20.r,
              //       ),
              //       SizedBox(width: 10.w),
              //       Text(
              //         'Filter',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w400,
              //           fontSize: 15.sp,
              //         ),
              //       ),
              //     ],
              //   ),
              //   onPressed: () async {
              //     SharedPreferences prefs = await SharedPreferences.getInstance();
              //     prefs.containsKey('filterByPrice') ? prefs.remove('filterByPrice') : null;
              //     prefs.containsKey('filterByDistance') ? prefs.remove('filterByDistance') : null;
              //     prefs.containsKey('filterByCountry') ? prefs.remove('filterByCountry') : null;
              //     prefs.containsKey('sortByCheapest') ? prefs.remove('sortByCheapest') : null;
              //     prefs.containsKey('filterByAvailability') ? prefs.remove('filterByAvailability') : null;
              //     prefs.containsKey('sortByNearest') ? prefs.remove('sortByNearest') : null;
              //     prefs.containsKey('filterBySpeciality') ? prefs.remove('filterBySpeciality') : null;
              //     // test();
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (BuildContext context) {
              //           return FilterPractitionersScreen(
              //             practitionerCategory: widget.practitionersCategory,
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),

          // users listed
          Consumer(
            builder: (context, ScopedReader watch, child) {
              final allUsersAsyncVal = watch(allUsersModelProvider);
              return allUsersAsyncVal.when(
                data: (data) {
                  if (data.length == 0)
                    return Center(
                      child: Text(
                        'No match found',
                        style: TextStyle(),
                      ),
                    );

                  return Container(
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                    data[5].surname == "" ? "Name N/A" : data[5].surname,
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Color(0xff242424),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),

                                  Spacer(),

                                  //bookmark
                                ],
                              ),

                              //speciality
                              Text(
                                "Individual User",
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
                                          data[5].residence,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'Error fetching users. Please try again later.',
                    style: TextStyle(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
