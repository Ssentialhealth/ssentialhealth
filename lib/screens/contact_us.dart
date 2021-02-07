import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/widget.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Contact Us"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:  EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF00FFFF),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:24.0),
                        child: Text(
                          "Call to Speak to one of us",
                          style: largeTextStyle(),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                        child: Container(

                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 12,),
                              Text("CALL NOW",
                                style: TextStyle(
                                    color: Color(0xff163C4D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Text("Or Write to us Your Issue",style: mediumTextStyle(),),
                SizedBox(height: 8,),
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: textFieldInputDecoration("Email Address"),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              alignment: Alignment.centerLeft,
                              child: CountryListPick(
                                theme: CountryTheme(
                                    isShowFlag: true,
                                  isShowCode: false,
                                  isShowTitle: false
                                ),
                                initialSelection: '+253',
                                onChanged: (CountryCode code) {
                                  print(code.name);
                                  print(code.code);
                                  print(code.dialCode);
                                  print(code.flagUri);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 18,),
                          Container(
                            width: 230,
                            child: TextFormField(
                              decoration: textFieldInputDecoration("Phone Number"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Write a Message",
                    style: TextStyle(
                    color: Color(0xff163C4D),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  maxLength: 150,
                  decoration: textFieldInputDecoration("Input Message"),
                  maxLines: 8,
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff32687F)
                    ),
                    child: Text("SUBMIT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }
}
