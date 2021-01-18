import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_health/models/SignUpResponse.dart';
import 'package:pocket_health/screens/home_screen.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:http/http.dart' as http;



class SignUpScreen extends StatefulWidget {
  final Function toggle;
  SignUpScreen(this.toggle);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController fullNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController userCategoryTextEditingController = new TextEditingController();
  TextEditingController countryTextEditingController = new TextEditingController();

  bool _isSubmitting = false;
  bool _isLoading = false;

  String _dropDownValue;
  String _country;
  String value = '';



  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_isLoading? new Container(
      color: Colors.white,
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 5,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/logonotag.png',
                                  height: 150,
                                  width: 150,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 39.0),
                                ),
                              ],
                            )),
                        Text(
                          "Please Register to Access more features",
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 2
                                  ? "Enter Full Name"
                                  : null;
                            },
                            controller: fullNameTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Full Names")
                        ),
                        SizedBox(height: 8,),
                        DropdownButtonFormField(
                          decoration: textFieldInputDecoration("User Category"),
                          hint: _dropDownValue == null
                              ? Text('')
                              : Text(
                            _dropDownValue,
                            style: TextStyle(color: Colors.black),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: ['Individual', 'Health Practitioner', 'Health Facility','Health Insurer', 'Health Insurance Agent'].map(
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
                                _dropDownValue = val;
                              },
                            );
                          },
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
                           initialSelection: '+253',
                           onChanged: (CountryCode code) {
                              print(code.name);
                              print(code.code);
                              print(code.dialCode);
                              print(code.flagUri);
                              _country = code.name;
                            },
                    ),
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                            validator: (val) {
                              return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                                  ? null
                                  : "Enter a valid Email";
                            },
                            controller: emailTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Email")
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Please provide a Password with 6+ characters";
                            },
                            controller: passWordTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Pin")
                        ),
                        SizedBox(height: 8,),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password ?",
                              style: simpleTextStyle(),
                            ),
                          ),
                        ),
                        new Align(child: loadingIndicator,alignment: FractionalOffset.topCenter,),

                        GestureDetector(
                          onTap: () {
                            signUp();


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
                            child: Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an Account ?", style: mediumTextStyle(),),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text("Sign In", style: TextStyle(
                                    color: Color(0xFF163C4D),
                                    fontSize: 17,
                                    decoration: TextDecoration.underline
                                )
                                  ,),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }

  signUp(){
    if(formKey.currentState.validate()){
      Map<String,String> _payload = Map();
      _payload['email'] = emailTextEditingController.text;
      _payload["password"] = passWordTextEditingController.text;
      _payload["full_names"] = fullNameTextEditingController.text;
      _payload["user_category"] = _dropDownValue.toLowerCase();
      _payload["country"] = _country;

      setState(() {
        _isLoading = true;

      });

      print(_payload);

      http.post(
        "https://ssential.herokuapp.com/accounts/users/",
        headers: {"Content-Type": "application/json"},
        body: json.encode(_payload)
      ).then((response){


        print(response.body);
        print("status code:" + response.statusCode.toString());

        SignUpResponse signUpResponse = SignUpResponse.fromJson(json.decode(response.body));

        if(response.statusCode == 201) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen()
          ));
          _showSnackBar("Successfully Created");
        } else {
          _showSnackBar(response.body.substring(11,response.body.length - 3));
          setState(() {
            _isLoading = false;
          });
        }

      }).catchError((e){
        print(e.toString());
      });

    }
  }

  void _showSnackBar(message) {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
        )
    );
  }




}
