import 'package:flutter/material.dart';
import 'package:pocket_health/screens/home/home_screen.dart';
import 'package:pocket_health/widgets/widget.dart';

import '../Authentication/Authenticate.dart';

class WaitScreen extends StatefulWidget {
  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/undraw_Mobile_life_re_jtih.png',
                        height: 250,
                        width: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an Account ?", style: mediumTextStyle(),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Authenticate()
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Sign In",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF163C4D),
                        fontSize: 17,
                        decoration: TextDecoration.underline
                    )
                      ,),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => HomeScreen()
                  ));
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
                  child: Text("Explore App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold

                    ),
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
