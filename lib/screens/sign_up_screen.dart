import 'dart:convert';

import 'package:flutter/material.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
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
                      TextFormField(
                          // validator: (val) {
                          //   return val.isEmpty || val.length < 2
                          //       ? "Enter Full Name"
                          //       : null;
                          // },
                          controller: userCategoryTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("User Category")
                      ),
                      TextFormField(
                          // validator: (val) {
                          //   return val.isEmpty || val.length < 2
                          //       ? "Try another Username"
                          //       : null;
                          // },
                          controller: countryTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Country")
                      ),
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
                      TextFormField(
                          obscureText: true,
                          validator: (val) {
                            return val.length > 6
                                ? null
                                : "Please provide a Password with 6+ characters";
                          },
                          controller: passWordTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Password")
                      ),
                    ],
                  ),
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
                SizedBox(height: 8,),
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
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC)
                            ]
                        )
                    ),
                    child: Text("Sign Up",
                      style: mediumTextStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(height: 16,),
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
                        child: Text("Sign In now", style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline
                        )
                          ,),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50,),

              ],
            ),
          ),
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
      _payload["user_category"] = userCategoryTextEditingController.text;
      _payload["country"] = countryTextEditingController.text;

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
