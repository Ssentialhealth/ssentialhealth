import 'package:flutter/material.dart';
import 'package:pocket_health/blocs/form_bloc.dart';
import 'package:pocket_health/mixins/helper.dart';
import 'package:pocket_health/providers/form_provider.dart';

import 'forgot_password.dart';
import 'signup_screen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FormProvider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 230.0,left: 50.0,right: 50.0),
            height: 550.0,
            child: Form(
              child: Column(
                children: <Widget>[
                  _emailField(formBloc),
                  _passwordField(formBloc),
                  Container(
                    width: 300,
                    height: 35,
                    child:
                      Helper.errorMessage(formBloc),
                    ),
                  _button(formBloc),
                  _forgotPassword(context)
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  Widget _emailField(FormBloc formBloc) {
    return StreamBuilder<String>(
        stream: formBloc.email,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email',
              errorText: snapshot.error,
            ),
            onChanged:formBloc.changeEmail,

          );
        }
    );
  }

  Widget _passwordField(FormBloc formBloc) {
    return StreamBuilder<String>(
        stream: formBloc.password,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            maxLength: 20,
            decoration: InputDecoration(
              hintText: 'Pin',
              labelText: 'Pin',
              errorText: snapshot.error,
            ),
            onChanged: formBloc.changePassword,

          );
        }
    );
  }

  Widget _button(FormBloc formBloc){
    return StreamBuilder<bool>(
        stream: formBloc.submitValidForm,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: RaisedButton(
              onPressed: (){
                if(snapshot.hasError){
                  return null;
                }
                return formBloc.login(context);
              },
              child: const Icon(Icons.arrow_forward),
              color: Colors.amber,
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              disabledColor: Colors.blueGrey,
              disabledElevation: 10,
              disabledTextColor: Colors.white,
            ),
          );
        }
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forgotPassword'),
          child: Container(
            child: Text('Forgot Password'),
            alignment: Alignment.bottomRight,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/signUp'),
          child: Container(
            child: Text('Sign Up'),
            alignment: Alignment.bottomRight,
          ),
        ),
      ],
    );

  }


}
