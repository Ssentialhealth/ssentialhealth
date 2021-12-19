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
