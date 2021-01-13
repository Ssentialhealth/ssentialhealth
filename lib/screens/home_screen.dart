import 'package:flutter/material.dart';
import 'package:pocket_health/services/auth_service.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 400),
          child: Column(
            children: [
              Text('Home Screen'),
              RaisedButton(
                child: Text('Log out'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                  AuthService.removeToken();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

