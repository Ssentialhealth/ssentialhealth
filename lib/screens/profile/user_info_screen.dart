import 'dart:convert';
import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactBloc.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactEvent.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactState.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileBloc.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileState.dart';
import 'package:pocket_health/bloc/profile/userProfileBloc.dart';
import 'package:pocket_health/bloc/profile/userProfileEvent.dart';
import 'package:pocket_health/bloc/profile/userProfileState.dart';
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    _name = await getStringValuesSF();
    emailValue = await getEmailValuesSF();

    setState(() {
      _fullName = _name;
      _email = emailValue;
    });
    print(_fullName);
  }

  String _fullName;

  String _email;
  String _name;

  double percentage = 0.25;
  String percentageNumber = "25";

  String emailValue;

  String value;
  int currentStep = 0;
  bool complete = false;
  String countryCode, country, gender, bloodGroup, chronicCondition, mental,
      disabilities, longTerm, dAllergies, fAllergies, dateOfBirth, chronic,
      recreational, admissionDate;
  List<Step> steps;
  TextEditingController surname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController residence = new TextEditingController();
  TextEditingController region = new TextEditingController();
  TextEditingController conditions = new TextEditingController();
  TextEditingController ambulanceName = new TextEditingController();
  TextEditingController ambulancePhone = new TextEditingController();
  TextEditingController insurerName = new TextEditingController();
  TextEditingController insuranceNumber = new TextEditingController();
  TextEditingController insurerNumber = new TextEditingController();
  TextEditingController kinNumber = new TextEditingController();
  TextEditingController kinRelation = new TextEditingController();
  TextEditingController kinName = new TextEditingController();


  List<Step> _buildSteps() {
    steps = [
      Step(
        title: Text('Personal '),
        isActive: true,
        content: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                readOnly: true,
                controller: surname,
                decoration: lockFieldInputDecoration(_fullName),
              ),
              SizedBox(height: 8,),
              TextFormField(
                readOnly: true,
                decoration: lockFieldInputDecoration(_email),
              ),
              SizedBox(height: 8,),

              ///TODO
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.centerLeft,
                      child: CountryListPick(
                        theme: CountryTheme(
                            isShowFlag: true,
                            isShowCode: false,
                            isShowTitle: false
                        ),
                        initialSelection: '+255',
                        onChanged: (CountryCode code) {
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                          countryCode = code.dialCode;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 18,),
                  Container(
                    width: 230,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phone,
                      decoration: textFieldInputDecoration("Phone Number"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Others"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              SizedBox(height: 8,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Date of Birth"
                  )
              ),
              SizedBox(height: 5,),
              TextFormField(
                readOnly: true,
                decoration: dateFieldInputDecoration(dateOfBirth),
                controller: dob,
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 3, 5),
                      maxTime: DateTime(2021, 6, 7),
                      onChanged: (date) {
                        // print('change $date');
                      },
                      onConfirm: (date) {
                        // print('confirm $date');
                        setState(() {
                          var dob = date.toString();
                          var dates = DateTime.parse(dob);
                          var formattedDate = "${dates.year}-${dates
                              .month}-${dates.day}";

                          dateOfBirth = formattedDate;

                          print(formattedDate);
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en);
                },
              ),
              // DropdownButtonFormField(
              //   decoration: textFieldInputDecoration("Date of Birth"),
              //   hint: dateOfBirth == null
              //       ? Text('')
              //       : Text(
              //     dateOfBirth,
              //     style: TextStyle(color: Colors.black),
              //   ),
              //   isExpanded: true,
              //   iconSize: 30.0,
              //   style: TextStyle(color: Colors.black),
              //
              //   onTap: (){
              //     DatePicker.showDatePicker(context,
              //         showTitleActions: true,
              //         minTime: DateTime(1963, 3, 5),
              //         maxTime: DateTime(2021, 6, 7),
              //         onChanged: (val) {
              //           setState(() {
              //             dateOfBirth = val.toString();
              //             print("DOB:"+val.toString());
              //           });
              //           print('change $val');
              //         }, onConfirm: (date) {
              //           print('confirm $date');
              //         }, currentTime: DateTime.now(), locale: LocaleType.en);
              //   },
              // ),
              SizedBox(height: 8,),
              DropdownButtonFormField(
                decoration: textFieldInputDecoration("Gender"),
                hint: gender == null
                    ? Text('')
                    : Text(
                  gender,
                  style: TextStyle(color: Colors.black),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: [
                  'male',
                  'female',
                  'Transgender Female',
                  'Transgender Male',
                  'Intersex,',
                  'Non-binary',
                  'Other',
                  'Leave Blank',
                ].map(
                      (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                        () {
                      gender = val;
                    },
                  );
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: residence,
                decoration: textFieldInputDecoration("Residence"),
              ),
              SizedBox(height: 8,),
              //TODO
              TextFormField(
                controller: region,
                decoration: textFieldInputDecoration("Region/Town/Locality"),
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text("Health"),
        isActive: true,
        content: Column(
          children: <Widget>[
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Blood Group"),
              hint: bloodGroup == null
                  ? Text('')
                  : Text(
                bloodGroup,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['O+', 'O-', 'AB+', 'AB-', 'A-', 'A+', 'B+', 'B-'].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    bloodGroup = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Chronic Condition"),
              hint: chronicCondition == null
                  ? Text('')
                  : Text(
                chronicCondition,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Diabetes',
                'Hypertension,',
                'Heart Failure',
                'Cancer,',
                'Congenital,',
                'Asthma',
                'Eczema',
                'Convulsion disorder',
                'Neuro-developmental disorder',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    chronicCondition = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Mental Condition"),
              hint: mental == null
                  ? Text('')
                  : Text(
                mental,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Depression',
                'Anxiety',
                'Bipolar',
                'Psychosis',
                'Substance Dependency',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    mental = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Disabilities"),
              hint: disabilities == null
                  ? Text('')
                  : Text(
                disabilities,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Limbs',
                'Neuromuscular',
                'Hearing',
                'Seeing',
                'Speech',
                'Neurodevelopmental',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    disabilities = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Long Term Medications"),
              hint: longTerm == null
                  ? Text('')
                  : Text(
                longTerm,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Inhalers',
                'Other anti-asthma',
                'Insulin',
                'Other anti-diabetes',
                'Anti-hypertension',
                'Anti- heart failure',
                'Anti-cancer',
                'Radiotherapy',
                'Anti-convulsant',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    longTerm = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Other Health Information"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration(
                  "Chronic Condition In Family"),
              hint: chronic == null
                  ? Text('')
                  : Text(
                chronic,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Diabetes',
                'Hypertension,',
                'Heart Failure',
                'Cancer,',
                'Congenital,',
                'Asthma',
                'Eczema',
                'Convulsion disorder',
                'Neuro-developmental disorder',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    chronic = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Recreational Drug Use"),
              hint: recreational == null
                  ? Text('')
                  : Text(
                recreational,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Alcohol',
                'Tobacco,',
                'Marijuana',
                'Cocaine',
                'Heroin',
                'Other opioids',
                'Others Usage',
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    recreational = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Allergies"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Drug Allergies"),
              hint: dAllergies == null
                  ? Text('')
                  : Text(
                dAllergies,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Penicillin',
                'Sulphur',
                'Cephalosporins',
                'Aspirin',
                'NSAIDs',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    dAllergies = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Food Allergies"),
              hint: fAllergies == null
                  ? Text('')
                  : Text(
                fAllergies,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'None',
                'Peanut',
                'Eggs',
                'Meat',
                'Fish',
                'Cow’s Milk',
                'Lactose',
                'Other'
              ].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    fAllergies = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Previous Admissions(optional)"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Date of Admission"
                )
            ),
            SizedBox(height: 5,),
            TextFormField(
              readOnly: true,
              decoration: dateFieldInputDecoration(admissionDate),
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1900, 3, 5),
                    maxTime: DateTime(2021, 6, 7),
                    onChanged: (date) {
                      // print('change $date');
                    },
                    onConfirm: (date) {
                      // print('confirm $date');
                      setState(() {
                        var dob = date.toString();
                        var dates = DateTime.parse(dob);
                        var formattedDate = "${dates.year}-${dates
                            .month}-${dates.day}";

                        admissionDate = formattedDate;

                        print(formattedDate);
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en);
              },
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: conditions,
              maxLines: 4,
              maxLength: 40,
              decoration: textFieldInputDecoration("Conditions"),
            ),
            SizedBox(height: 8,),
            GestureDetector(
              onTap: () {
                BlocProvider.of<UserProfileBloc>(context).add(
                    CreateUserProfile(
                        surname: _fullName,
                        phone: phone.text,
                        dob: dateOfBirth,
                        gender: gender,
                        residence: residence.text,
                        country: region.text,
                        blood: bloodGroup,
                        chronic: chronic,
                        longTerm: longTerm,
                        date: admissionDate,
                        condition: conditions.text,
                        code: countryCode,
                        dissabilities: disabilities,
                        recreational: recreational,
                        drugAllergies: dAllergies,
                        foodAllergies: fAllergies,
                        photo: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fstatic.statusqueen.in%2Fdpimages%2Fthumbnail%2Fdp_images_8-1279.jpg&imgrefurl=https%3A%2F%2Fstatusqueen.com%2Fdp&tbnid=YqVegUIARCFAQ"


                    ));
              },
              child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileInitial) {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xff163C4D),
                                const Color(0xff32687F)
                              ]
                          )
                      ),
                      child: Text("Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  } else if (state is UserProfileLoading) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.black,);
                  }
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xff163C4D),
                              const Color(0xff32687F)
                            ]
                        )
                    ),
                    child: Text("Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),

      ),
      Step(
        title: Text("Additional"),
        isActive: true,
        content: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Preferred Ambulance Services(optional)"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              TextFormField(
                validator: (val) {
                  return val.length < 0 ? null : "Please provide a Name";
                },
                controller: ambulanceName,
                decoration: textFieldInputDecoration("AmbulanceName"),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.centerLeft,
                      child: CountryListPick(
                        theme: CountryTheme(
                            isShowFlag: true,
                            isShowCode: false,
                            isShowTitle: false
                        ),
                        initialSelection: '+254',
                        onChanged: (CountryCode code) {
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 18,),
                  Container(
                    width: 230,
                    child: TextFormField(
                      validator: (val) {
                        return val.length < 0
                            ? null
                            : "Please provide a Number";
                      },
                      keyboardType: TextInputType.number,
                      controller: ambulancePhone,
                      decoration: textFieldInputDecoration("Phone Number"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Health Insurer(optional)"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              TextFormField(
                validator: (val) {
                  return val.length < 0 ? null : "Please provide a Name";
                },
                decoration: textFieldInputDecoration("Name"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                validator: (val) {
                  return val.length < 0 ? null : "Please provide Policy Number";
                },
                decoration: textFieldInputDecoration(
                    "Insurance Number/Policy Number"),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.centerLeft,
                      child: CountryListPick(
                        theme: CountryTheme(
                            isShowFlag: true,
                            isShowCode: false,
                            isShowTitle: false
                        ),
                        initialSelection: '+254',
                        onChanged: (CountryCode code) {
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 18,),
                  Container(
                    width: 230,
                    child: TextFormField(
                      validator: (val) {
                        return val.length < 0
                            ? null
                            : "Please provide a Number";
                      },
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Phone Number"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Emergency Contact"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              TextFormField(
                validator: (val) {
                  return val.length < 0 ? null : "Please provide a Name";
                },
                controller: kinName,
                decoration: textFieldInputDecoration("Name"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                validator: (val) {
                  return val.length < 0
                      ? null
                      : "Please provide a Relationship Status";
                },
                controller: kinRelation,
                decoration: textFieldInputDecoration("Relationship"),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.centerLeft,
                      child: CountryListPick(
                        theme: CountryTheme(
                            isShowFlag: true,
                            isShowCode: false,
                            isShowTitle: false
                        ),
                        initialSelection: '+254',
                        onChanged: (CountryCode code) {
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 18,),
                  Container(
                    width: 230,
                    child: TextFormField(
                      validator: (val) {
                        return val.length < 0
                            ? null
                            : "Please provide a Number";
                      },
                      keyboardType: TextInputType.number,
                      controller: kinNumber,
                      decoration: textFieldInputDecoration("Phone Number"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<EmergencyContactBloc>(context).add(
                      AddContacts(
                          ambulanceName: ambulanceName.text,
                          countryCode: countryCode,
                          ambulancePhone: ambulancePhone.text,
                          insurerName: insurerName.text,
                          insuaranceNumber: insuranceNumber.text,
                          insuarerNumber: insurerNumber.text,
                          emergenceName: kinName.text,
                          emergencyRelation: kinRelation.text,
                          emergencyNumber: kinNumber.text
                      )
                  );
                },
                child: BlocBuilder<EmergencyContactBloc, EmergencyContactState>(
                  builder: (context, state) {
                    if (state is EmergencyContactInitial) {
                      return Container(
                        alignment: Alignment.center,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xff163C4D),
                                  const Color(0xff32687F)
                                ]
                            )
                        ),
                        child: Text("Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    } else if (state is EmergencyContactLoading) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xff163C4D),
                                const Color(0xff32687F)
                              ]
                          )
                      ),
                      child: Text("Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    ];
    return steps;
  }


  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      // listenWhen: (previous,current) => false,
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            if (state.profile.id != null) {
              setState(() {
                percentage = 0.75;
                percentageNumber = "75";
              });
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return PlatformAlertDialog(
                    title: Text('Profile Successfully Created'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Profile Successfully Created', style: TextStyle(
                              color: Colors
                                  .lightBlueAccent),),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      PlatformDialogAction(
                        child: Text('Proceed'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),

                    ],
                  );
                },
              );

            }
          }
          else if (state is UserProfileError) {
            _showSnackBar(state.errorMessage);
            // return showDialog<void>(
            //   context: context,
            //   builder: (BuildContext context) {
            //     // return PlatformAlertDialog(
            //     //   title: Text('Profile Not Created'),
            //     //   content: SingleChildScrollView(
            //     //     child: ListBody(
            //     //       children: <Widget>[
            //     //         Text("Please Enter Fill all the Fields", style: TextStyle(color: Colors
            //     //             .lightBlueAccent),),
            //     //
            //     //       ],
            //     //     ),
            //     //   ),
            //     //   actions: <Widget>[
            //     //     PlatformDialogAction(
            //     //       child: Text('Proceed'),
            //     //       onPressed: () {
            //     //         Navigator.of(context).pop();
            //     //       },
            //     //     ),
            //     //
            //     //   ],
            //     // );
            //     return Container();
            //   },
            // );
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Profile"),
            backgroundColor: Color(0xFF00FFFF),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                height: 190,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Color(0xFF00FFFF),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: ClipOval(
                                child: _image == null ? Image.asset(
                                  "assets/images/profile.png", height: 150,
                                  width: 150,
                                  fit: BoxFit.fill,) : Image.file(_image)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 9,),
                      Text("$_fullName", style: mediumTextStyle(),),
                      SizedBox(height: 9,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.0),
                        child: LinearPercentIndicator(
                          width: 240.0,
                          lineHeight: 8.0,
                          percent: percentage,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xff163C4D),
                        ),
                      ),
                      SizedBox(height: 9,),
                      Text("Sign Up Progress $percentageNumber%",
                        style: TextStyle(fontSize: 12),),

                    ],
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: Theme(
                    data: ThemeData(canvasColor: Colors.white,
                        primaryColor: Color(0xff163C4D)),
                    child: Stepper(
                      type: StepperType.horizontal,
                      steps: _buildSteps(),
                      currentStep: currentStep,
                      onStepCancel: cancel,
                      onStepContinue: next,
                      onStepTapped: (step) => goTo(step),
                    ),
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
    void _showSnackBar(message) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(message),
          )
      );
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('fullName');
    return stringValue;
  }

  getEmailValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('email');
    return stringValue;
  }
