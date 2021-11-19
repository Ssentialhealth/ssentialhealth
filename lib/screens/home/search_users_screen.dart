import 'dart:developer';

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
          searchedByName.isNotEmpty
              ? Consumer(
                  builder: (context, ScopedReader watch, child) {
                    final allUsersAsyncVal = watch(allUsersModelProvider);

                    return allUsersAsyncVal.when(
                      data: (data) {
                        log(data.last.surname);
                        final searchedUsers = data.where((e) => e.surname.toLowerCase().contains(searchedByName.toLowerCase())).toList();
                        // data.forEach((element) {
                        //   print(element.surname);
                        // });

                        if (searchedUsers.length == 0)
                          return Text(
                            'No match found',
                            style: TextStyle(),
                          );

                        return Text(
                          searchedUsers.last.surname,
                          style: TextStyle(),
                        );
                      },
                      loading: () => Text(
                        'loading',
                        style: TextStyle(),
                      ),
                      error: (error, stack) => Text(
                        'error',
                        style: TextStyle(),
                      ),
                    );
                  },
                  child: Text(
                    'child',
                    style: TextStyle(),
                  ),
                )
              : Text(
                  'search empty',
                  style: TextStyle(),
                ),
        ],
      ),
    );
  }
}
