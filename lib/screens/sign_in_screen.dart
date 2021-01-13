import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_health/models/LoginResponse.dart';
import 'package:pocket_health/screens/home_screen.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  bool _isSubmitting = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      validator: (val){
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
                      validator: (val){
                        return val.length > 6 ? null : "Please provide a Password with 6+ characters";
                      },
                      controller: passWordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Password")
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.centerRight,
                    child:   Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forgot Password ?",
                        style: simpleTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){

                     login();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
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
                      child: Text("Sign In",
                        style: mediumTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account ?",style: mediumTextStyle(),),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Register now",style: TextStyle(
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
      ),
    );
  }


  login() {
    if (formKey.currentState.validate()) {
      Map<String,String> _payLoad = Map();
      _payLoad['email'] = emailTextEditingController.text;
      _payLoad["password"] = passWordTextEditingController.text;

      print(_payLoad);

      http.post(
          "https://ssential.herokuapp.com/token/login/",
          headers: {"Content-Type": "application/json"},
          body: json.encode(_payLoad)
      ).then((response) {
        setState(() {
          _isSubmitting = false;
        });

        print(response.body);
        print("status code: " + response.statusCode.toString());

        LoginResponse loginResponse =
        LoginResponse.fromJson(json.decode(response.body));

        if(response.statusCode == 200) {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomeScreen()
          ));
          addStringToSF(loginResponse.token);
          print(loginResponse.token);
        }else{
          _showSnackBar(response.body.substring(22,response.body.length - 3));
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

  addStringToSF(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', value);
  }
}





