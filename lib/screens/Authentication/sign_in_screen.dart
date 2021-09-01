import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginEvent.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/screens/home/home.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoaded) {
              final userID = state.loginModel.user.fullNames;
              final client = context.read<InitializeStreamChatCubit>().client;
              final userCategory = state.loginModel.user.userCategory;

              context.read<InitializeStreamChatCubit>()..initializeUser(userID, userCategory);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return StreamChat(
                      client: client,
                      child: Home(),
                    );
                  },
                ),
              );
            }
            if (state is LoginError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text("No active account found with the given credentials")));
            }
          },
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
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (val) {
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter a valid Email";
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
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        validator: (val) {
                          return val.length < 5 ? null : "Please provide a Pin with four digits";
                        },
                        controller: passWordTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Pin")),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Forgot Pin ?",
                            style: simpleTextStyle(),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState.validate()) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(SendLoginPayLoad(email: emailTextEditingController.text, password: passWordTextEditingController.text));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), gradient: LinearGradient(colors: [const Color(0xff163C4D), const Color(0xff32687F)])),
                        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                          if (state is LoginLoading) {
                            return CircularProgressIndicator();
                          }
                          return Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Need an Account?",
                          style: mediumTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Color(0xFF163C4D), fontSize: 17, decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
