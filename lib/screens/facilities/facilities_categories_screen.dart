import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/list_facilities/list_facilities_cubit.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'facilities_list_screen.dart';
import 'facilities_view_disclaimer.dart';

class FacilitiesCategoriesScreen extends StatefulWidget {
  @override
  _FacilitiesCategoriesScreenState createState() => _FacilitiesCategoriesScreenState();
}

class _FacilitiesCategoriesScreenState extends State<FacilitiesCategoriesScreen> {
  String _token;
  bool isAgreed = false;

  final List<String> facilitiesCategories = [
    "All",
    "Hospitals",
    "Clinics",
    "Pharmacies",
    "Occupational Therapy",
    "Mental Health",
    "Labs & Diagnostics",
    "Imaging Centres",
    "Rehabilitation",
    "Physiotherapy",
    "Hospice",
    "Others",
  ];

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    return stringValue;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool agreeViewFacilitites = prefs.getBool('isAgreed-facilities');
      agreeViewFacilitites == null ? isAgreed = false : isAgreed = true;

      if (!isAgreed || isAgreed == null) {
        _token = await getStringValuesSF();

        if (_token != null)
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return FacilitiesViewDisclaimer(
                disclaimerText: 'This offers a platform to consult with facilities on health related advice, complementing other health provision systems.',
              );
            },
          );
        else
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return FacilitiesViewDisclaimer(
                disclaimerText: 'Please Log in or Sign up to see and contact available hospitals, pharmacies and other health facilities.',
              );
            },
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Health Facilities',
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
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
                    image: AssetImage('assets/images/facilities_banner.png'),
                  ),
                ),
              ],
            ),

            //list of sub sections
            ...List.generate(
              facilitiesCategories.length,
              (index) => Column(
                children: [
                  //tile
                  ListTile(
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xff00FFFF),
                    ),
                    title: Text(
                      facilitiesCategories[index],
                      style: listTileTitleStyle,
                    ),
                    onTap: () {
                      final facilitiesCategory = facilitiesCategories[index];
                      context.read<ListFacilitiesCubit>()..listFacilities(facilitiesCategory);
                      //push practitioner listing for each category
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return FacilitiesListScreen(
                              facilitiesCategory: facilitiesCategory,
                            );
                          },
                        ),
                      );
                    },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
