import 'package:flutter/material.dart';
import 'package:pocket_health/Authenticate.dart';
import 'package:pocket_health/screens/sign_in_screen.dart';
import 'package:pocket_health/widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forgot Pin"),
          centerTitle: true,
          brightness: Brightness.light,
        ),
        body: Container(
          child: Padding(
            padding:  EdgeInsets.all(12.0),
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
                  decoration: textFieldInputDecoration("Email"),

                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
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
        )
      ),
    );
  }
}
