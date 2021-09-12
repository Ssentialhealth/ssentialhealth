import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/bloc/list_facilities/list_facilities_cubit.dart';
import 'package:pocket_health/screens/practitioners/filter_title.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterFacilitiesScreen extends StatefulWidget {
  final String facilitiesCategory;

  const FilterFacilitiesScreen({Key key, this.facilitiesCategory}) : super(key: key);

  @override
  _FilterFacilitiesScreenState createState() => _FilterFacilitiesScreenState();
}

class _FilterFacilitiesScreenState extends State<FilterFacilitiesScreen> {
  String countryVal = "KE";
  String availabilityVal = "null";
  bool isFiltering = false;
  bool cheapestVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7FFFF),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leadingWidth: 80.w,
        leading: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.containsKey('filterFacilitiesByPrice') ? prefs.remove('filterFacilitiesByPrice') : null;
            prefs.containsKey('filterFacilitiesByDistance') ? prefs.remove('filterFacilitiesByDistance') : null;
            prefs.containsKey('filterFacilitiesByAvailability') ? prefs.remove('filterFacilitiesByAvailability') : null;
            prefs.containsKey('filterFacilitiesByCountry') ? prefs.remove('filterFacilitiesByCountry') : null;
            prefs.containsKey('filterFacilitiesBySpeciality') ? prefs.remove('filterFacilitiesBySpeciality') : null;
            prefs.containsKey('sortFacilitiesByCheapest') ? prefs.remove('sortFacilitiesByCheapest') : null;
            prefs.containsKey('sortFacilitiesByNearest') ? prefs.remove('sortFacilitiesByNearest') : null;
            prefs.containsKey('sortByHighestRated') ? prefs.remove('sortByHighestRated') : null;
            context.read<ListFacilitiesCubit>()..listFacilities(widget.facilitiesCategory);
            Navigator.pop(context);
          },
          child: Text(
            'Clear All',
            style: appBarStyle.copyWith(
              fontSize: 15.sp,
              color: Color(0xff1A5864),
            ),
          ),
        ),
        title: Text(
          "Filter",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //sort
              FilterTitle(filter: "SORT BY"),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              //cheapest
              Theme(
                data: ThemeData(
                  checkboxTheme: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    fillColor: MaterialStateProperty.all(Color(0xFF00FFFF)),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                child: CheckboxListTile(
                  isThreeLine: false,
                  tristate: false,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                  tileColor: Colors.white,
                  dense: true,
                  value: cheapestVal,
                  title: Text(
                    'Cheapest',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff707070),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (val) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('sortByCheapest', val);

                    setState(() {
                      cheapestVal = val;
                    });
                  },
                ),
              ),
              Divider(height: 0.0, thickness: 0.5, indent: 20.r, endIndent: 20.r, color: Color(0xffB3B3B3)),
              //availability
              Theme(
                data: ThemeData(
                  checkboxTheme: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    fillColor: MaterialStateProperty.all(Color(0xFF00FFFF)),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                child: CheckboxListTile(
                  isThreeLine: false,
                  tristate: false,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                  tileColor: Colors.white,
                  dense: true,
                  value: availabilityVal == "true" ? true : false,
                  title: Text(
                    'Available',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff707070),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (val) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('filterFacilitiesByAvailability', val);

                    setState(() {
                      availabilityVal = val == true ? "true" : "false";
                    });
                  },
                ),
              ),

              //COUNTRY
              FilterTitle(filter: "COUNTRY"),
              Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

              CountryListPick(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0.0,
                  leadingWidth: 80.w,
                  title: Text(
                    "Pick Country",
                    style: appBarStyle.copyWith(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                ),
                pickerBuilder: (context, code) {
                  return ListTile(
                    isThreeLine: false,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                    tileColor: Colors.white,
                    dense: true,
                    leading: Image.asset(
                      Uri.parse(code.flagUri).toFilePath(),
                      package: 'country_list_pick',
                      width: 32.w,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24.r,
                      color: accentColor,
                    ),
                    title: Row(
                      children: [
                        Text(
                          code.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff707070),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          code.dialCode,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: accentColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                useSafeArea: true,
                initialSelection: '+254',
                onChanged: (val) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('filterFacilitiesByCountry', val.code);
                  setState(() {
                    countryVal = val.code;
                  });

                  print('--------|country code|--------|value -> ${val.code.toString()}');
                },
              ),

              //apply
              Center(
                child: MaterialButton(
                  minWidth: 374.w,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  focusElevation: 0.0,
                  disabledElevation: 0.0,
                  color: Color(0xff1A5864),
                  height: 40.h,
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: isFiltering
                      ? CircularProgressIndicator(
                          color: accentColorLight,
                          backgroundColor: accentColorDark,
                        )
                      : Text(
                          'Apply Filters',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                  onPressed: () async {
                    setState(() {
                      isFiltering = true;
                    });

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    final filterFacilitiesByDistance = prefs.getDouble('filterFacilitiesByDistance');
                    final filterFacilitiesByPrice = prefs.getDouble('filterFacilitiesByPrice');
                    // final filterFacilitiesByAvailability = prefs.getBool('filterFacilitiesByAvailability');
                    // final filterFacilitiesByCountry = prefs.getString('filterFacilitiesByCountry');
                    final sortByCheapest = prefs.getBool('sortFacilitiesByCheapest');
                    final sortByNearest = prefs.getBool('sortFacilitiesByNearest');
                    final sortByHighestRated = prefs.getBool('sortFacilitiesByHighestRated');

                    context.read<ListFacilitiesCubit>()
                      ..filterFacilities(
                        filterByDistance: filterFacilitiesByDistance.toString(),
                        filterByPrice: filterFacilitiesByPrice.toString(),
                        sortByHighestRated: sortByHighestRated.toString(),
                        sortByNearest: sortByNearest.toString(),

                        //done
                        filterByAvailability: availabilityVal.toString(),
                        sortByCheapest: cheapestVal.toString(),
                        facilityCategory: widget.facilitiesCategory.toString(),
                        filterFacilitiesByCountry: countryVal,
                      );

                    Navigator.pop(context);
                    print('sortByCheapest   | $sortByCheapest');
                    print('sortByNearest   | $sortByNearest');
                    print('sortByNearest   | $sortByNearest');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
