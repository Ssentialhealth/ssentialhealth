import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/screens/doctor_consult/doctor_consult.dart';
import 'package:pocket_health/screens/emergency_screens/hotlines_landing_screen.dart';
import 'package:pocket_health/screens/home/search_users_screen.dart';
import 'package:pocket_health/screens/practitioners/practitioners_categories_screen.dart';
import 'package:pocket_health/screens/profile/profile_screen.dart';
import 'package:pocket_health/utils/constants.dart';

import 'home_screen.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;

  List<Widget> tabPages = [
    HomeScreen(),
    HotlineScreen(),
    DoctorConsult(),
    ProfileScreen(),
  ];

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SearchUsersScreen(fromFAB: true);
                        },
                      ),
                    );
                  },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff163C4D),
        iconSize: 24,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedItemColor: Color(0xffACBBBE),
        backgroundColor: accentColorLight,
        elevation: 16.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/home.png'),
              size: 24,
              color: Color(0xff163C4D),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/emergency.png'),
              size: 24,
              color: Color(0xffEC6363),
            ),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/consult.png'),
              size: 24,
              color: Color(0xff0A77C4),
            ),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/account.png'),
              size: 24,
              color: Color(0xeb163c4d),
            ),
            label: 'Account',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
