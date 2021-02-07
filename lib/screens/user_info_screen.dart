import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pocket_health/widgets/widget.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {

  List<Step> steps = [
    Step(
      title: const Text('Personal '),
      isActive: false,
      state: StepState.complete,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Personal'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Health '),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Health'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Postcode'),
          ),
        ],
      ),
    ),
    Step(
      state: StepState.editing,
      title: const Text('Other'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Other'),
          ),
        ],
      ),
    ),
  ];

int currentStep = 0;
bool complete = false;

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
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              steps: steps,
              currentStep: currentStep,
              onStepCancel: next,
              onStepContinue: cancel,
              onStepTapped: (step) => goTo(step),
            ),
          ),

        ],
      ),
    );
  }
}
