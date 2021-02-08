import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocket_health/widgets/widget.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String value;
  int currentStep = 0;
  bool complete = false;
  String gender,bloodGroup,disorder,mental,disabilities,longTerm,dAllergies,fAllergies;
  List<Step> steps;


  List<Step> _buildSteps() {
    steps = [
      Step(
        title:  Text('Personal '),
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
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Others"
                )
            ),
            Divider(color: Color(0xff163C4D)),
            SizedBox(height: 8,),
            TextFormField(
              decoration: textFieldInputDecoration("Date of Birth"),
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
            TextFormField(
              decoration: textFieldInputDecoration("Residence"),
            ),
            SizedBox(height: 8,),
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
                },
              ),
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
                hint: disorder == null
                    ? Text('')
                    : Text(
                  disorder,
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
                          disorder = val;
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
                decoration: textFieldInputDecoration("Chronic conditions in Family"),
              ),
              SizedBox(height: 8,),
              TextFormField(
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
                items: ['Penicillin', 'Sulphur', 'Cephalosporins','Aspirin','NSAIDs','Other'].map(
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
                decoration: textFieldInputDecoration("Date"),
              ),
              SizedBox(height: 8,),
              TextFormField(
                maxLines: 5,
                decoration: textFieldInputDecoration("Conditions"),
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
                decoration: textFieldInputDecoration("Name"),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Emergency Contact"
                  )
              ),
              Divider(color: Color(0xff163C4D)),
              TextFormField(
                decoration: textFieldInputDecoration("Name"),
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
