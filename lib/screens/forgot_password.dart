import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/forgotPassword/forgortPasswordEvent.dart';
import 'package:pocket_health/bloc/forgotPassword/forgotPasswordBloc.dart';
import 'package:pocket_health/screens/Authenticate.dart';
import 'package:pocket_health/widgets/widget.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


  TextEditingController emailTextEditingController = new TextEditingController();

  bool _autoValidate = false;
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_isLoading? new Container(
      color: Colors.white,
      width: 70.0,
      height: 70.0,
      child:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Center(
              child:  CircularProgressIndicator())),
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
                      BlocProvider.of<ForgotPasswordBloc>(context).add(GetResetEmail(email: emailTextEditingController.text));
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



}

