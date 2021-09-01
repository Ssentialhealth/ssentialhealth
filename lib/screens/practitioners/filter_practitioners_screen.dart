import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'by_speciality.dart';
import 'filter_title.dart';

class FilterPractitionersScreen extends StatefulWidget {
  final String practitionerCategory;

  const FilterPractitionersScreen({
    Key key,
    this.practitionerCategory,
  }) : super(key: key);

  @override
  _FilterPractitionersScreenState createState() => _FilterPractitionersScreenState();
}

class _FilterPractitionersScreenState extends State<FilterPractitionersScreen> {
  double distanceVal = 5.0;
  String countryVal;
  double priceVal = 0.0;
  String distanceUnits = 'distanceUnit';
  String priceUnits = 'priceUnit';
  bool cheapestVal = false;
  bool highestRatedVal = false;
  bool availabilityVal = false;
  bool nearestVal = false;
  bool isFiltering = false;

  final List<String> specialities = [
    'General practitioners',
    'Family Physicians, Internists',
    'Pediatricians',
    'Pediatric, Children Surgeons',
    'Obstetric & Gynecologists',
    'Ear, Nose & Throat Specialists',
    'Eyes Specialists, Ophthalmologists',
    'General Surgeons',
    'Orthopedics',
    'Dermatologists',
    'Psychiatrists',
    'Pathologists',
    'Cancer Physicians',
    'Chest & Breathing Physicians',
    'Heart & Vascular Physicians',
    'Diabetes & Hormones Specialists',
    'Head, Brain & Neural Physicians',
    'Head, Brain & Neural Surgeons',
    'Digestive, Gut Physicians',
    'Gastroenterologists',
    'Urologists',
    'Plastic & Reconstruction Surgeons',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              prefs.containsKey('filterByPrice') ? prefs.remove('filterByPrice') : null;
              prefs.containsKey('filterByDistance') ? prefs.remove('filterByDistance') : null;
              prefs.containsKey('filterByAvailability') ? prefs.remove('filterByAvailability') : null;
              prefs.containsKey('filterByCountry') ? prefs.remove('filterByCountry') : null;
              prefs.containsKey('sortByCheapest') ? prefs.remove('sortByCheapest') : null;
              prefs.containsKey('sortByNearest') ? prefs.remove('sortByNearest') : null;
              prefs.containsKey('sortByHighestRated') ? prefs.remove('sortByHighestRated') : null;
              prefs.containsKey('filterBySpeciality') ? prefs.remove('filterBySpeciality') : null;
              context.read<ListPractitionersCubit>()..listPractitioners();
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

                //sort type
                Column(
                  children: [
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
                        value: nearestVal,
                        title: Text(
                          'Nearest',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff707070),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (val) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('sortByNearest', val);

                          setState(() {
                            nearestVal = val;
                          });
                        },
                      ),
                    ),
                    Divider(height: 0.0, thickness: 0.5, indent: 20.r, endIndent: 20.r, color: Color(0xffB3B3B3)),

                    //rating
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
                        value: highestRatedVal,
                        title: Text(
                          'Highest Rated',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff707070),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (val) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('sortByHighestRated', val);
                          setState(() {
                            highestRatedVal = val;
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
                        value: availabilityVal,
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
                          await prefs.setBool('filterByAvailability', val);

                          setState(() {
                            availabilityVal = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                widget.practitionerCategory == "Doctors" ? BySpeciality() : SizedBox.shrink(),

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
                    await prefs.setString('filterByCountry', val.dialCode);

                    setState(() {
                      countryVal = val.dialCode;
                    });
                  },
                ),

                //distance
                Padding(
                  padding: EdgeInsets.only(left: 20.r, top: 12.r, right: 20.r, bottom: 12.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DISTANCE",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 104.w,
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
                            size: 18.r,
                            color: accentColorDark,
                          ),
                          dropdownColor: accentColorLight,
                          value: 'Kilometeres',
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.r),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                width: 1.r,
                                color: accentColorDark,
                              ),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              distanceUnits = val;
                            });
                          },
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              value: 'Kilometeres',
                              child: Text(
                                'Kilometers',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: accentColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Miles",
                              child: Text(
                                'Miles',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: accentColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                //distance slider
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: 25.r, right: 10.r, left: 10.r, top: 10.r),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                      maxWidth: 1.sw,
                    ),
                    child: SfSlider(
                      value: distanceVal,
                      stepSize: distanceUnits == 'Miles' ? 6 : 10,
                      min: distanceUnits == 'Miles' ? 3.0 : 5.0,
                      max: distanceUnits == "Miles" ? 33.0 : 55.0,
                      interval: distanceUnits == 'Miles' ? 6 : 10,
                      showTicks: true,
                      showLabels: true,
                      activeColor: accentColor,
                      inactiveColor: Color(0xffC6C6C6),
                      enableTooltip: true,
                      labelFormatterCallback: (actualValue, label) {
                        final newLabel = distanceUnits == "Miles"
                            ? actualValue == 33
                                ? "MAX"
                                : label
                            : actualValue == 55
                                ? "MAX"
                                : label;
                        return newLabel;
                      },
                      tooltipTextFormatterCallback: (actualValue, label) {
                        final newLabel = distanceUnits == "Miles"
                            ? actualValue == 33
                                ? "MAX"
                                : label
                            : actualValue == 55
                                ? "MAX"
                                : label;
                        return newLabel;
                      },
                      minorTicksPerInterval: 0,
                      onChanged: (dynamic val) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        final filterByDistance = prefs.getDouble('filterByDistance');
                        filterByDistance ?? prefs.remove('filterByDistance');
                        setState(() {
                          distanceVal = val;
                        });
                        await prefs.setDouble('filterByDistance', val);
                      },
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                //price
                Padding(
                  padding: EdgeInsets.only(left: 20.r, top: 12.r, right: 20.r, bottom: 12.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PRICE",
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
                          value: 'KSH',
                          elevation: 1,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 18.r,
                            color: accentColorDark,
                          ),
                          dropdownColor: accentColorLight,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.r),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                width: 1.r,
                                color: accentColorDark,
                              ),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              priceUnits = val;
                            });
                          },
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              value: "USD",
                              child: Text(
                                'USD',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: accentColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "KSH",
                              child: Text(
                                'KSH',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: accentColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                //price slider
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: 25.r, right: 10.r, left: 10.r, top: 10.r),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                      maxWidth: 1.sw,
                    ),
                    child: SfSlider(
                      value: priceVal,
                      showTicks: true,
                      minorTicksPerInterval: 0,
                      stepSize: priceUnits == 'USD' ? 10 : 1000,
                      min: 0.0,
                      max: priceUnits == "USD" ? 60.0 : 6000.0,
                      interval: priceUnits == 'USD' ? 10 : 1000,
                      showLabels: true,
                      activeColor: accentColor,
                      inactiveColor: Color(0xffC6C6C6),
                      enableTooltip: true,
                      //formatters
                      labelFormatterCallback: (actualValue, label) {
                        final kshLabel = label == "1000"
                            ? '1,000'
                            : label == "2000"
                                ? '2,000'
                                : label == "3000"
                                    ? "3,000"
                                    : label == "4000"
                                        ? '4,000'
                                        : label == "5000"
                                            ? "5,000"
                                            : label == "6000"
                                                ? 'MAX'
                                                : label == "0"
                                                    ? "0"
                                                    : '';
                        final usdLabel = label == "60" ? 'MAX' : label;
                        final newLabel = priceUnits == 'USD' ? usdLabel : kshLabel;

                        return newLabel;
                      },
                      tooltipTextFormatterCallback: (actualValue, label) {
                        final kshLabel = label == "1000"
                            ? '1,000'
                            : label == "2000"
                                ? '2,000'
                                : label == "3000"
                                    ? "3,000"
                                    : label == "4000"
                                        ? '4,000'
                                        : label == "5000"
                                            ? "5,000"
                                            : label == "6000"
                                                ? 'MAX'
                                                : label == "0"
                                                    ? "0"
                                                    : '';
                        final usdLabel = label == "60" ? 'MAX' : label;
                        final newLabel = priceUnits == 'USD' ? usdLabel : kshLabel;

                        return newLabel;
                      },

                      //on change
                      onChanged: (dynamic val) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        final filterByPrice = prefs.getDouble('filterByPrice');
                        filterByPrice ?? prefs.remove('filterByPrice');

                        setState(() {
                          priceVal = val;
                        });
                        await prefs.setDouble('filterByPrice', val);
                      },
                    ),
                  ),
                ),

                Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

                SizedBox(height: 20.h),
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
                      final filterByDistance = prefs.getDouble('filterByDistance');
                      final filterByPrice = prefs.getDouble('filterByPrice');
                      final sortByCheapest = prefs.getBool('sortByCheapest');
                      final sortByNearest = prefs.getBool('sortByNearest');
                      final filterByAvailability = prefs.getBool('filterByAvailability');
                      final sortByHighestRated = prefs.getBool('sortByHighestRated');
                      final specialityIndex = prefs.getInt('filterBySpeciality');
                      final filterBySpeciality = specialityIndex != null ? specialities[specialityIndex] : 'null';

                      context.read<ListPractitionersCubit>()
                        ..filterPractitioners(
                          filterByDistance: filterByDistance.toString(),
                          filterByPrice: filterByPrice.toString(),
                          filterBySpeciality: filterBySpeciality.toString(),
                          sortByCheapest: sortByCheapest.toString(),
                          filterByAvailability: filterByAvailability.toString(),
                          sortByHighestRated: sortByHighestRated.toString(),
                          sortByNearest: sortByNearest.toString(),
                          practitionersCategory: widget.practitionerCategory,
                        );

                      Navigator.pop(context);
                      print('filterByDistance   | $filterByDistance');
                      print('filterByPrice   | $filterByPrice');
                      print('sortByCheapest   | $sortByCheapest');
                      print('sortByNearest   | $sortByNearest');
                      print('sortByNearest   | $sortByNearest');
                      print('filterByAvailability   | $filterByAvailability');
                      print('filterBySpecialityText   | $filterBySpeciality');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//region CATEGORY_CODE
// // category
// FilterTitle(filter: "CATEGORY"),
// Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),
// DropdownButtonFormField(
//   isExpanded: true,
//   icon: Icon(
//     Icons.keyboard_arrow_down,
//     size: 24.r,
//     color: accentColor,
//   ),
//   decoration: InputDecoration(
//     enabledBorder: InputBorder.none,
//     border: InputBorder.none,
//     focusedBorder: InputBorder.none,
//     fillColor: Colors.white,
//     filled: true,
//     contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
//   ),
//   elevation: 0,
//   menuMaxHeight: 0.25.sh,
//   style: TextStyle(
//     fontSize: 14.sp,
//     color: Color(0xff707070),
//     fontWeight: FontWeight.w600,
//   ),
//   dropdownColor: Colors.white,
//   hint: Text(
//     'Select Category',
//     style: TextStyle(
//       fontSize: 14.sp,
//       color: Color(0xff707070),
//       fontWeight: FontWeight.w600,
//     ),
//   ),
//   onTap: () {},
//   onChanged: (val) {
//     setState(() {
//       categoryVal = val;
//     });
//   },
//   items: [
//     DropdownMenuItem(
//       value: "TEST1",
//       onTap: () {},
//       child: Text('test'),
//     ),
//     DropdownMenuItem(
//       value: "TEST2",
//       child: Text('test2'),
//     ),
//     DropdownMenuItem(
//       value: "TEST3",
//       onTap: () {},
//       child: Text('test'),
//     ),
//     DropdownMenuItem(
//       value: "TEST7",
//       child: Text('test2'),
//     ),
//     DropdownMenuItem(
//       value: "TEST5",
//       onTap: () {},
//       child: Text('test'),
//     ),
//     DropdownMenuItem(
//       value: "TEST9",
//       child: Text('test2'),
//     ),
//   ],
// ),
// Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),

//speciality
//endregion
