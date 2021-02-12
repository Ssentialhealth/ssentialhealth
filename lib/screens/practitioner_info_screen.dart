import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocket_health/widgets/widget.dart';

class PractitionerInfo extends StatefulWidget {
  @override
  _PractitionerInfoState createState() => _PractitionerInfoState();
}

class _PractitionerInfoState extends State<PractitionerInfo> {
  String value;
  int currentStep = 0;
  bool complete = false;
  String gender,bloodGroup,disorder,mental,disabilities,longTerm,dAllergies,fAllergies;
  List<Step> steps;

  next() {
    currentStep +1 != steps.length
        ? goTo(currentStep +1)
        : setState(() => complete = true);
  }
  cancel(){
    if(currentStep > 0){
      goTo(currentStep - 1);
    }
  }
  goTo(int step){
    setState(() =>  currentStep = step);
  }

  List<Step> _buildSteps() {
    steps = [
      Step(
        title:  Text('General'),
        isActive: true,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: textFieldInputDecoration("Nicolas Dani"),
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: textFieldInputDecoration("Surname"),
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: textFieldInputDecoration("Email"),
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: textFieldInputDecoration("Location"),
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Region"),
              hint: gender == null
                  ? Text('')
                  : Text(
                gender,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Male', 'Female', 'Prefer Not to Say'].map(
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
                    decoration: textFieldInputDecoration("Phone Number"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),





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
              hint: bloodGroup == null
                  ? Text('')
                  : Text(
                bloodGroup,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Hospital', 'Clinic', 'Pharmacy','Health Insurer','Rehab','Physio, Lab & Diagnostics','Imaging Centres','Mental Health Facility','Hospice','Specialties','Others'].map(
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
              decoration: textFieldInputDecoration("Care Type"),
              hint: disorder == null
                  ? Text('')
                  : Text(
                disorder,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Not Applicable', 'Comprehensive', 'Outpatient Only','Outpatient & Inpatient','Rehabilitation','Preventive','Mental Health (Psychiatry/Psychology) Wellness','Other'].map(
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
                    disorder = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            DropdownButtonFormField(
              decoration: textFieldInputDecoration("Practitioner Category"),
              hint: mental == null
                  ? Text('')
                  : Text(
                mental,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Not Applicable', 'Doctor', 'Dentist','Nurse','Pharmacist','Clinician','Physician Assistant', 'Paramedic','Psychologist','Counsellor','Physiotherapist','Other'].map(
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
              decoration: textFieldInputDecoration("Speciality"),
              hint: disabilities == null
                  ? Text('')
                  : Text(
                disabilities,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Not Applicable', 'General Practice', 'Family Physician','Internist','Pediatrics','Pediatric Surgery','Obstetrics & Gynecology','Ear','Nose & Throat Specialty','Eye Specialty','General Surgery','Other'].map(
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
            TextFormField(
              decoration: textFieldInputDecoration("Affiliated Institution (Facility or Company"),
            ),

          ],
        ),

      ),
      Step(
        title: Text("Rates"),
        isActive: true,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: textFieldInputDecoration("Operating Times(enter text or number)"),
            ),
            SizedBox(height: 8,),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Online Booking"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: textFieldInputDecoration("Region"),
                    hint: gender == null
                        ? Text('')
                        : Text(
                      gender,
                      style: TextStyle(color: Colors.black),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['Male', 'Female', 'Prefer Not to Say'].map(
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

                ),
                SizedBox(width: 18,),
                Expanded(
                  child: Container(
                    width: 230,
                    child: TextFormField(
                      decoration: textFieldInputDecoration("Phone Number"),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical:8.0,),
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xff163C4D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text("ADD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "In Person Booking"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
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
                    decoration: textFieldInputDecoration("Phone Number"),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical:8.0,),
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xff163C4D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text("ADD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Follow-up In Person Rates"
                )
            ),
            Divider(color: Color(0xff163C4D)),
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
                    decoration: textFieldInputDecoration("Phone Number"),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical:8.0,),
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xff163C4D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text("SAVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    ];
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding:  EdgeInsets.symmetric(vertical:8.0),
              child: Column(
                children: [
                  Image.asset("assets/images/profile.png"),
                  SizedBox(height: 9,),
                  Text("Nicholas Dani",style: mediumTextStyle(),),
                  SizedBox(height: 9,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:60.0),
                    child: LinearPercentIndicator(
                      width: 240.0,
                      lineHeight: 8.0,
                      percent: 0.3,
                      backgroundColor: Colors.white,
                      progressColor: Color(0xff163C4D),
                    ),
                  ),
                  SizedBox(height: 9,),
                  Text("Sign Up Progress 10%",style: TextStyle(fontSize: 12),),

                ],
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Theme(
                data: ThemeData(canvasColor: Colors.white,primaryColor: Color(0xff163C4D)),

                child: Stepper(
                  type: StepperType.horizontal,
                  steps: _buildSteps(),
                  currentStep: currentStep,
                  onStepCancel: next,
                  onStepContinue: cancel,
                  onStepTapped: (step) => goTo(step),
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }
}
