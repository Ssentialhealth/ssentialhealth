import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//endpoints
final String loginEndpoint = "https://ssential.herokuapp.com/api/token/";
final String registerEndpoint = "https://ssential.herokuapp.com/auth/users/";
final String forgotPassEndpoint = "https://ssential.herokuapp.com/auth/users/reset_password/";
final String createProfileEndpoint = "https://ssential.herokuapp.com/api/user/profile/";
final String createPractitionerProfileEndpoint = "https://ssential.herokuapp.com/api/user/practitioner_profile/";
final String addContactsEndpoint = "https://ssential.herokuapp.com/api/user/emergency_details/";
final String getHotlines = "https://ssential.herokuapp.com/api/emergency/hotlines?country=";

//styles
TextStyle appBarStyle = TextStyle(
  color: Color(0xff373737),
  fontSize: 17.sp,
  fontWeight: FontWeight.w600,
);

TextStyle listTileTitleStyle = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  color: Color(0xff373737),
);
TextStyle listTileSubTitleStyle = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xff373737),
);

TextStyle sectionTitle = TextStyle(
  color: Color(0xff373737),
  fontWeight: FontWeight.w600,
  fontSize: 15.sp,
);

//colors
Color accentColor = Color(0xFF00FFFF);
Color accentColorLight = Color(0xffE7FFFF);
Color accentColorDark = Color(0xff1A5864);
Color textBlack = Color(0xff373737);
final String immunizationEndpoint = "https://ssential.herokuapp.com/api/child_health/immunization_schedule/";
final String vaccinesEndpoint = "https://ssential.herokuapp.com/api/child_health/immunization_schedule/vaccines/";
final String allSchedulesEndpoint = "https://ssential.herokuapp.com/api/child_health/immunization_schedule/";
