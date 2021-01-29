import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_health/models/LoginResponse.dart';
import 'package:pocket_health/screens/home_screen.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';


class SignInScreen extends StatefulWidget {

  final Function toggle;
  SignInScreen(this.toggle);




  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  bool _isLoading = false;
  bool _isSubmitting = false;


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
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
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
                    "Please Login to Access more features",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 8,),
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
                      decoration: textFieldInputDecoration("Email"),

                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    maxLength: 4,
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],
                      validator: (val){
                        return val.length < 5 ? null : "Please provide a Pin with four digits";
                      },
                      controller: passWordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Pin")
                  ),

                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child:   Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Forgot Pin ?",
                          style: simpleTextStyle(),
                        ),
                      ),
                    ),
                  ),
                  new Align(child: loadingIndicator,alignment: FractionalOffset.topCenter,),
                  GestureDetector(
                    onTap: (){
                     login();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
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
                      child: Text("Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Need an Account?",style: mediumTextStyle(),),
                      GestureDetector(
                        onTap: (){
                            widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Sign Up",style: TextStyle(
                              color: Color(0xFF163C4D),
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

      setState(() {
        _isLoading = true;

      });

      print(_payLoad);

      http.post(
          "https://ssential.herokuapp.com/api/token/",
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
          _showSnackBar(response.body.substring(11,response.body.length - 2));
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

  addStringToSF(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', value);
  }



}



// _isLoading ?
// CircularProgressIndicator(
// backgroundColor: Color(0xff163C4D),
// valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow,),
// )
// :




