import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/screens/doctor_consult/doctor_consult.dart';
import 'package:pocket_health/screens/emergency_screens/hotlines_landing_screen.dart';
import 'package:pocket_health/screens/practitioners/practitioners_categories_screen.dart';
import 'package:pocket_health/screens/profile/profile_screen.dart';
import 'package:pocket_health/utils/constants.dart';

import 'home_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> tabPages = [HomeScreen(), HotlineScreen(), DoctorConsult(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FFFF),
      body: tabPages[_selectedIndex],
      floatingActionButton: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: accentColorDark,
            child: Icon(
              Icons.add,
              color: accentColorLight,
            ),
            onPressed: state is LoginLoaded && state.loginModel.user.userCategory == 'individual'
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PractitionersCategoriesScreen(fromFAB: true);
                        },
                      ),
                    );
                  }
                : () {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xff163C4D),
                          duration: Duration(milliseconds: 6000),
                          content: Text(
                            'This feature is only available to users registered as individuals!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                  },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/images/icons/Home_colored.png',
              height: 20,
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/images/icons/emergency red.png',
              height: 20,
              width: 20,
            ),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/images/icons/doctor_consult_colored.png',
              height: 20,
              width: 20,
            ),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/images/icons/settings.png',
              height: 20,
              width: 20,
            ),
            label: 'Account',
          ),
        ],
        selectedItemColor: Color(0xff163C4D),
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            // context.read<InitializeStreamChatCubit>().initialize('MochogeDavid');
          }
        },
      ),
    );
  }
}
