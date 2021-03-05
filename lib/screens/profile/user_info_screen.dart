import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactBloc.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactEvent.dart';
import 'package:pocket_health/bloc/profile/userProfileBloc.dart';
import 'package:pocket_health/bloc/profile/userProfileEvent.dart';
import 'package:pocket_health/widgets/widget.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String value;
  int currentStep = 0;
  bool complete = false;
  String countryCode,country,gender,bloodGroup,chronicCondition,mental,disabilities,longTerm,dAllergies,fAllergies;
  List<Step> steps;
  TextEditingController surname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController residence = new TextEditingController();
  TextEditingController chronic = new TextEditingController();
  TextEditingController recreational = new TextEditingController();
  TextEditingController admissionDate = new TextEditingController();
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
        title:  Text('Personal '),
        isActive: true,
        content: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: surname,
                decoration: textFieldInputDecoration("Surname"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                decoration: textFieldInputDecoration("Email"),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Others"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              SizedBox(height: 8,),
              TextFormField(
                controller: dob,
                decoration: textFieldInputDecoration("DOB(YYYY-MM-DD)"),
              ),
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
                items: ['male', 'female', 'Prefer Not to Say'].map(
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                ),
                alignment: Alignment.centerLeft,
                child: CountryListPick(
                  theme: CountryTheme(
                      isShowFlag: true
                  ),
                  initialSelection: '+254',
                  onChanged: (CountryCode code) {
                    print(code.name);
                    print(code.code);
                    print(code.dialCode);
                    print(code.flagUri);
                    country = code.name;

                  },
                ),
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
                items: ['O+', 'O-', 'AB+','AB-','A-','B+','B-'].map(
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
                items: ['None', 'Diabetes', 'Hypertension,','Heart Failure','Cancer,','Congenital,','Asthma','Eczema','Convulsion disorder','Neuro-developmental disorder','Other'].map(
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
                items: ['None', 'Depression', 'Anxiety','Bipolar','Psychosis','Substance Dependency','Other'].map(
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
                items: ['None', 'Limbs', 'Neuromuscular','Hearing','Seeing','Speech','Neurodevelopmental','Other'].map(
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
                items: ['None', 'Inhalers', 'Other anti-asthma','Insulin','Other anti-diabetes','Anti-hypertension','Anti- heart failure','Anti-cancer','Radiotherapy','Anti-convulsant','Other'].map(
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
              TextFormField(
                controller: chronic,
                decoration: textFieldInputDecoration("Chronic conditions in Family"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: recreational,
                decoration: textFieldInputDecoration("Recreational Drug Use"),
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
                items: ['None','Penicillin', 'Sulphur', 'Cephalosporins','Aspirin','NSAIDs','Other'].map(
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
                items: ['Peanut', 'Eggs', 'Meat','Fish','Cow’s Milk','Lactose','Other'].map(
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
              TextFormField(
                controller: admissionDate,
                decoration: textFieldInputDecoration("Date(YYYY-MM-DD)"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: conditions,
                maxLines: 5,
                decoration: textFieldInputDecoration("Conditions"),
              ),
              SizedBox(height: 8,),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<UserProfileBloc>(context).add(
                      CreateUserProfile(
                          surname: surname.text,
                          phone: phone.text,
                          dob: dob.text,
                          gender: gender,
                          residence: residence.text,
                          country: country,
                          blood: bloodGroup,
                         chronic: chronic.text,
                        longTerm: longTerm,
                        date: admissionDate.text,
                        condition: conditions.text,
                        code: countryCode,
                        dissabilities: disabilities,
                        recreational: recreational.text,
                        drugAllergies: dAllergies,
                        foodAllergies: fAllergies,

                      ));


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
                  child: Text("Submit",
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
      Step(
          title: Text("Additional"),
          isActive: true,
          content: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Ambulance Services(optional)"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              TextFormField(
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
                decoration: textFieldInputDecoration("Name"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: textFieldInputDecoration("Insurance Number/Policy Number"),
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
                controller: kinName,
                decoration: textFieldInputDecoration("Name"),
              ),
              SizedBox(height: 8,),
              TextFormField(
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
                  child: Text("Submit",
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
