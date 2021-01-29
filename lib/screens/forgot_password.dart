import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_health/Authenticate.dart';
import 'package:pocket_health/models/ForgotPassResponse.dart';
import 'package:pocket_health/screens/sign_in_screen.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:http/http.dart' as http;


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = new TextEditingController();



  String _email;
  bool _autoValidate = false;
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_isLoading? new Container(
      color: Colors.white,
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
          title: Text("Forgot Pin"),
          centerTitle: true,
          brightness: Brightness.light,
        ),
        body: Container(
          child: Padding(
            padding:  EdgeInsets.all(12.0),
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(top:24),
                    child: Text("Enter the Email address to registered"
                        " with and we will send you a link to reset your pin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black
                    ),),
                  ),
                  SizedBox(height: 24,),
                  TextFormField(
                    validator: (val){
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)
                          ? null
                          : "Enter a valid Email";
                    },
                    // controller: emailTextEditingController,
                    style: simpleTextStyle(),
                    controller: emailTextEditingController,
                    decoration: textFieldInputDecoration("Email"),

                  ),
                  SizedBox(height: 15,),
                  new Align(child: loadingIndicator,alignment: FractionalOffset.topCenter,),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      forgotPass();
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
                      child: Text("Reset Pin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
                    },
                    child: Text("BACK TO SIGN IN",style: TextStyle(
                        color: Color(0xFF163C4D),
                        fontSize: 17,
                    )),
                  ),


                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  forgotPass(){
    if(_formKey.currentState.validate()) {
      Map<String,String> _payLoad = Map();
      _payLoad['email'] = emailTextEditingController.text;
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;

      });

      http.post("https://ssential.herokuapp.com/auth/users/reset_password/",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(_payLoad)
      ).then((response) {
        print("status code:" + response.statusCode.toString());


        ForgotPasswordResponse forgotPassword = ForgotPasswordResponse.fromJson(
            jsonDecode(response.body));
        print(_email.toString());

        if (response.statusCode == 204) {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Authenticate()
          ));
          _showSnackBar(response.body);
         } else {
          _showSnackBar(response.body.substring(2,response.body.length -2));
          setState(() {
            _isLoading = false;
          });        }
      }
    ).catchError((e){
      _showSnackBar("Check Your Email , We have Sent a Link to Reset your Password");
      setState(() {
        _isLoading = false;
      });
      });
      
    }
  }

  void _showSnackBar(message) {
   _scaffoldKey.currentState.showSnackBar(
     SnackBar(
       content: Text(message),
          ),
        );
      }

}

