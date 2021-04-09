import 'package:flutter/material.dart';
import 'package:pocket_health/screens/emergency_screens/emergency_hotlines_screen.dart';
import 'package:pocket_health/screens/emergency_screens/hotlines_landing_screen.dart';
import 'package:pocket_health/screens/home/account_page.dart';
import 'package:pocket_health/screens/home/doctor_consult.dart';
import 'package:pocket_health/screens/profile/profile_screen.dart';

import 'home_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> tabPages = [
    HomeScreen(),
    HotlineScreen(),
    DoctorConsult(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FFFF),
      body: tabPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/icons/Home_colored.png',height: 20,width:20,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/icons/emergency red.png',height: 20,width:20,),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/icons/doctor_consult_colored.png',height: 20,width:20,),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/icons/settings.png',height: 20,width:20,),
            label: 'Account',
          ),
        ],
        selectedItemColor: Color(0xff163C4D),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
