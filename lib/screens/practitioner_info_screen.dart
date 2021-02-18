import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileBloc.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileEvent.dart';
import 'package:pocket_health/widgets/widget.dart';

class PractitionerInfo extends StatefulWidget {
  @override
  _PractitionerInfoState createState() => _PractitionerInfoState();
}

class _PractitionerInfoState extends State<PractitionerInfo> {
  String value;
  int currentStep = 0;
  bool complete = false;
  String countryCode,healthInstitution,careType,practitioner,speciality,upto15,upto30,upto1,bookingVisit,bookingHour,followVisit,followHour;
  List<Step> steps;

  TextEditingController surname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController region = new TextEditingController();
  TextEditingController affiliatedF = new TextEditingController();
  TextEditingController quaterHour = new TextEditingController();
  TextEditingController perVisit = new TextEditingController();
  TextEditingController perFollow = new TextEditingController();


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
              controller: surname,
              decoration: textFieldInputDecoration("Surname"),
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: textFieldInputDecoration("Email"),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: location,
              decoration: textFieldInputDecoration("Location"),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: region,
              decoration: textFieldInputDecoration("Region"),
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
                        healthInstitution = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
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
                        careType = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
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
                        practitioner = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
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
                        speciality = val;
                  },
                );
              },
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: affiliatedF,
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
                    decoration: textFieldInputDecoration("Time"),
                    hint: upto15 == null
                        ? Text('')
                        : Text(
                      upto15,
                      style: TextStyle(color: Colors.black),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['Upto 15Min'].map(
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
                              upto15 = val;
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
                      controller: quaterHour,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Charges"),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 8,),
            // Row(
            //   children: [
            //     Expanded(
            //       child: DropdownButtonFormField(
            //         decoration: textFieldInputDecoration("Time"),
            //         hint: upto30 == null
            //             ? Text('')
            //             : Text(
            //           upto30,
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         isExpanded: true,
            //         iconSize: 30.0,
            //         style: TextStyle(color: Colors.black),
            //         items: ['Upto 30Min'].map(
            //               (val) {
            //             return DropdownMenuItem<String>(
            //               value: val,
            //               child: Text(val),
            //             );
            //           },
            //         ).toList(),
            //         onChanged: (val) {
            //           setState(
            //                 () {
            //                   upto30 = val;
            //             },
            //           );
            //         },
            //       ),
            //
            //     ),
            //     SizedBox(width: 18,),
            //     Expanded(
            //       child: Container(
            //         width: 230,
            //         child: TextFormField(
            //           controller: affiliatedF,
            //           decoration: textFieldInputDecoration("Charges"),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 8,),
            // Row(
            //   children: [
            //     Expanded(
            //       child: DropdownButtonFormField(
            //         decoration: textFieldInputDecoration("Time"),
            //         hint: upto1 == null
            //             ? Text('')
            //             : Text(
            //           upto1,
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         isExpanded: true,
            //         iconSize: 30.0,
            //         style: TextStyle(color: Colors.black),
            //         items: ['Upto 60Min'].map(
            //               (val) {
            //             return DropdownMenuItem<String>(
            //               value: val,
            //               child: Text(val),
            //             );
            //           },
            //         ).toList(),
            //         onChanged: (val) {
            //           setState(
            //                 () {
            //                   upto1 = val;
            //             },
            //           );
            //         },
            //       ),
            //
            //     ),
            //     SizedBox(width: 18,),
            //     Expanded(
            //       child: Container(
            //         width: 230,
            //         child: TextFormField(
            //           controller: quaterHour,
            //           decoration: textFieldInputDecoration("Charges"),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "In Person Booking"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: textFieldInputDecoration("Type"),
                    hint: bookingVisit == null
                        ? Text('')
                        : Text(
                      bookingVisit,
                      style: TextStyle(color: Colors.black),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['Per Visit'].map(
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
                              bookingVisit = val;
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
                      controller: perVisit,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Charges"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            // Row(
            //   children: [
            //     Expanded(
            //       child: DropdownButtonFormField(
            //         decoration: textFieldInputDecoration("Type"),
            //         hint: bookingHour == null
            //             ? Text('')
            //             : Text(
            //           bookingHour,
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         isExpanded: true,
            //         iconSize: 30.0,
            //         style: TextStyle(color: Colors.black),
            //         items: ['Per Hour'].map(
            //               (val) {
            //             return DropdownMenuItem<String>(
            //               value: val,
            //               child: Text(val),
            //             );
            //           },
            //         ).toList(),
            //         onChanged: (val) {
            //           setState(
            //                 () {
            //                   bookingHour = val;
            //             },
            //           );
            //         },
            //       ),
            //
            //     ),
            //     SizedBox(width: 18,),
            //     Expanded(
            //       child: Container(
            //         width: 230,
            //         child: TextFormField(
            //           controller: affiliatedF,
            //           decoration: textFieldInputDecoration("Charges"),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 8,),
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
                  child: DropdownButtonFormField(
                    decoration: textFieldInputDecoration("Type"),
                    hint: followVisit == null
                        ? Text('')
                        : Text(
                      followVisit,
                      style: TextStyle(color: Colors.black),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: ['Per Visit'].map(
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
                              followVisit = val;
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
                      controller: perFollow,
                      keyboardType: TextInputType.number,
                      decoration: textFieldInputDecoration("Charges"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            // Row(
            //   children: [
            //     Expanded(
            //       child: DropdownButtonFormField(
            //         decoration: textFieldInputDecoration("Type"),
            //         hint: followHour == null
            //             ? Text('')
            //             : Text(
            //           followHour,
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         isExpanded: true,
            //         iconSize: 30.0,
            //         style: TextStyle(color: Colors.black),
            //         items: ['Per Hour'].map(
            //               (val) {
            //             return DropdownMenuItem<String>(
            //               value: val,
            //               child: Text(val),
            //             );
            //           },
            //         ).toList(),
            //         onChanged: (val) {
            //           setState(
            //                 () {
            //                   followHour = val;
            //             },
            //           );
            //         },
            //       ),
            //
            //     ),
            //     SizedBox(width: 18,),
            //     Expanded(
            //       child: Container(
            //         width: 230,
            //         child: TextFormField(
            //           controller: affiliatedF,
            //           decoration: textFieldInputDecoration("Charges"),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 8,),
            GestureDetector(
              onTap: () {

              BlocProvider.of<PractitionerProfileBloc>(context).add(
                CreatePractitionerProfile(
                    surname: surname.text,
                    onlinePrice: quaterHour.text,
                    personalPrice: perVisit.text,
                    followPrice: perFollow.text,
                    location: location.text,
                    region: region.text,
                    phone: phone.text,
                    healthInstitution: healthInstitution,
                    careType: careType,
                    practitioner: practitioner,
                    speciality: speciality,
                    affiliatedInstitution: affiliatedF.text,
                    operationTime: countryCode,
                    onlineBooking: upto15,
                    inPerson: bookingVisit,
                    followUp: followVisit
                )
              );


              },
              child: Container(
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
                child: Text("Update Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
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
          // Container(
          //   height: 180,
          //   width: MediaQuery.of(context).size.width,
          //   color: Color(0xFF00FFFF),
          //   child: Padding(
          //     padding:  EdgeInsets.symmetric(vertical:8.0),
          //     child: Column(
          //       children: [
          //         Image.asset("assets/images/profile.png"),
          //         SizedBox(height: 9,),
          //         Text("Nicholas Dani",style: mediumTextStyle(),),
          //         SizedBox(height: 9,),
          //         Padding(
          //           padding:  EdgeInsets.symmetric(horizontal:60.0),
          //           child: LinearPercentIndicator(
          //             width: 240.0,
          //             lineHeight: 8.0,
          //             percent: 0.3,
          //             backgroundColor: Colors.white,
          //             progressColor: Color(0xff163C4D),
          //           ),
          //         ),
          //         SizedBox(height: 9,),
          //         Text("Sign Up Progress 10%",style: TextStyle(fontSize: 12),),
          //
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            child: Expanded(
              child: Theme(
                data: ThemeData(canvasColor: Colors.white,primaryColor: Color(0xff163C4D)),

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

    );
  }
}
