import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filter_title.dart';

class BySpeciality extends StatefulWidget {
  @override
  _BySpecialityState createState() => _BySpecialityState();
}

class _BySpecialityState extends State<BySpeciality> {
  List<String> specialities = [
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

  String specialityVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterTitle(filter: "SPECIALITY"),
        Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),
        DropdownButtonFormField(
          isExpanded: true,
          elevation: 1,
          menuMaxHeight: 0.5.sh,
          dropdownColor: Colors.white,
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xff707070),
            fontWeight: FontWeight.w600,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 24.r,
            color: accentColor,
          ),
          hint: Text(
            'Select Speciality',
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xff707070),
              fontWeight: FontWeight.w600,
            ),
          ),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
          ),
          items: specialities
              .asMap()
              .entries
              .map(
                (entry) => DropdownMenuItem(
                  value: entry.key,
                  child: FittedBox(
                    child: Text(
                      entry.value,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (val) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('filterBySpeciality', val);
          },
        ),
        Divider(height: 1, thickness: 1.r, color: Color(0xffB3B3B3)),
      ],
    );
  }
}
