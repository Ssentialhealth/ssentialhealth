import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileBloc.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileEvent.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileState.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PractitionerInfo extends StatefulWidget {
  @override
  _PractitionerInfoState createState() => _PractitionerInfoState();
}

class _PractitionerInfoState extends State<PractitionerInfo> {
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

  double percentage = 0.25;
  String percentageNumber = "25";
  String _fullName;
  String _email;
  String emailValue;

  String _name;
  String value;
  int currentStep = 0;
  bool complete = false;
  String countryCode, healthInstitution, careType, practitioner, speciality, upto15, upto30, upto1, bookingVisit, bookingHour, followVisit, followHour;
  List<Step> steps;

  TextEditingController surname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController region = new TextEditingController();
  TextEditingController affiliatedF = new TextEditingController();
  TextEditingController fifteen = new TextEditingController();
  TextEditingController halfHour = new TextEditingController();
  TextEditingController bookingHourRate = new TextEditingController();
  TextEditingController visitHourRate = new TextEditingController();
  TextEditingController hour = new TextEditingController();
  TextEditingController perVisit = new TextEditingController();
  TextEditingController perFollow = new TextEditingController();

  next() {
    currentStep + 1 != steps.length ? goTo(currentStep + 1) : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  List<Step> _buildSteps() {
    steps = [
      Step(
        title: Text('General'),
        isActive: true,
        content: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              controller: surname,
              decoration: lockFieldInputDecoration(_fullName),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              readOnly: true,
              decoration: lockFieldInputDecoration(_email),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: location,
              decoration: textFieldInputDecoration("Location"),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: region,
              decoration: textFieldInputDecoration("Region/Town/Locality"),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.centerLeft,
                    child: CountryListPick(
                      theme: CountryTheme(isShowFlag: true, isShowCode: false, isShowTitle: false),
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
                SizedBox(
                  width: 18,
                ),
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
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      Step(
        title: Text("Health"),
        isActive: true,
        content: Column(
          children: <Widget>[
            DropdownButtonFormField(
	            decoration: textFieldInputDecoration("Health Institution"),
              hint: healthInstitution == null
                  ? Text('')
                  : Text(
                      healthInstitution,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'Not Applicable',
                'Hospital',
                'Clinic',
                'Pharmacy',
                'Health Insurer',
                'Rehab',
                'Physio',
                'Lab',
                'Diagnostics',
                'Imaging Centres',
                'Mental Health Facility',
                'Hospice',
                'Specialties',
                'Others'
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
                    healthInstitution = val;
                  },
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Care Type"),
              hint: careType == null
                  ? Text('')
                  : Text(
                      careType,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'Not Applicable',
                'Comprehensive',
                'Outpatient Only',
                'Outpatient & Inpatient',
                'Rehabilitation',
                'Preventive',
                'Mental Health (Psychiatry/Psychology)',
                ' Wellness',
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
                    careType = val;
                  },
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Practitioner Category"),
              hint: practitioner == null
                  ? Text('')
                  : Text(
                      practitioner,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'Not Applicable',
                'Doctor',
                'Dentist',
                'Nurse',
                'Pharmacist',
                'Clinician',
                'Physician Assistant',
                'Paramedic',
                'Psychologist',
                'Counsellor',
                'Physiotherapist',
                'Occupational therapist',
                'Speech Therapist',
                'Nutritionists & Dieticians',
                'Physical Trainer',
                ' Chiropractor',
                'Lab Personnel',
                'Health Insurance Agent',
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
                    practitioner = val;
                  },
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Speciality"),
              hint: speciality == null
                  ? Text('')
                  : Text(
                      speciality,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                'Not Applicable',
                'General Practice',
                'Family Physician',
                'Internist',
                'Pediatrics',
                'Children Surgery',
                'Obstetrics & Gynecology',
                'Ear,Nose & Throat Specialty',
                'Eye Specialty',
                'General Surgery',
                'Bone & Muscle',
                'Skin Dermatology',
                'Psychiatry',
                'Psychology',
                'Pathology',
                'Cancer Specialist',
                'Chest & Breathing',
                'Heart & Vessels - Cardiologist',
                'Chest Heart & Vascular Surgery',
                'Diabetes & Hormones Specialty',
                'Head Brain & Nerves Specialty',
                'Head Brain & Nerves Surgery',
                'Digestive Gut Specialty',
                'Urology',
                'Plastic & Reconstruction Surgery',
                'Anesthesia',
                'Allergy & Immunology',
                'Joints & Rheumatology',
                'Public Health',
                'Research',
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
                    speciality = val;
                  },
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: affiliatedF,
              decoration: textFieldInputDecoration("Affiliated Institution (Facility or Company"),
            ),
          ],
        ),
      ),
      Step(
        title: Text("Additional"),
        isActive: true,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: textFieldInputDecoration("Operating Times(enter text or number)"),
            ),
            SizedBox(
              height: 8,
            ),
            //online Booking//
            Align(alignment: Alignment.centerLeft, child: Text("Online Consult")),
            Divider(color: Color(0xff163C4D)),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("1 - 15 Minutes")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: fifteen,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("16 - 30 Minutes")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: halfHour,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("31 - 60 Minutes")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: hour,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            //In person Booking//
            Align(alignment: Alignment.centerLeft, child: Text("In Person Consult")),
            Divider(color: Color(0xff163C4D)),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("Per Visit")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: perVisit,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("Per Hour")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: bookingHourRate,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            //Follow up//
            Align(alignment: Alignment.centerLeft, child: Text("Follow-up In Person Rates")),
            Divider(color: Color(0xff163C4D)),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("Per Visit")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: perFollow,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: Text("Per Hour")),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      controller: visitHourRate,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Rates (USD)"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<PractitionerProfileBloc>(context).add(CreatePractitionerProfile(
                    surname: surname.text,
                    location: location.text,
                    region: region.text,
                    phone: phone.text,
                    healthInstitution: healthInstitution,
                    careType: careType,
                    practitioner: practitioner,
                    speciality: speciality,
                    affiliatedInstitution: affiliatedF.text,
                    operationTime: countryCode,
                    onlinePrice: fifteen.text,
                    onlinePriceB: halfHour.text,
                    onlinePriceC: hour.text,
                    personalPrice: perVisit.text,
                    personalBPrice: bookingHourRate.text,
                    followPrice: perFollow.text,
                    followBPrice: visitHourRate.text));
              },
              child: BlocBuilder<PractitionerProfileBloc, PractitionerProfileState>(builder: (context, state) {
                if (state is PractitionerProfileInitial) {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), gradient: LinearGradient(colors: [const Color(0xff163C4D), const Color(0xff32687F)])),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                } else if (state is PractitionerProfileLoading) {
                  return CircularProgressIndicator();
                }
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), gradient: LinearGradient(colors: [const Color(0xff163C4D), const Color(0xff32687F)])),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    ];
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PractitionerProfileBloc, PractitionerProfileState>(
        listener: (context, state) {
          if (state is PractitionerProfileLoaded) {
            if (state.practitionerProfile.user != null) {
              setState(() {
                percentage = 1.0;
                percentageNumber = "100";
              });
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return PlatformAlertDialog(
                    title: Text('Profile Successfully Created'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'Profile Successfully Created',
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
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
          } else if (state is PractitionerProfileError) {
            _showSnackBar(state.errorMessage);
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
                height: 180,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF00FFFF),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/profile.png"),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "$_fullName",
                        style: mediumTextStyle(),
                      ),
                      SizedBox(
                        height: 9,
                      ),
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
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "Sign Up Progress $percentageNumber%",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: Theme(
                    data: ThemeData(canvasColor: Colors.white, primaryColor: Color(0xff163C4D)),
                    child: Stepper(
                      type: StepperType.horizontal,
                      steps: _buildSteps(),
                      currentStep: currentStep,
                      onStepCancel: null,
                      onStepContinue: null,
                      onStepTapped: (step) => goTo(step),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _showSnackBar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
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
