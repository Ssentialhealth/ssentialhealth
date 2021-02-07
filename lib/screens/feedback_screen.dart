import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/feedback_item.dart';
import 'package:pocket_health/widgets/widget.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical:25.0,horizontal:10.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:16.0,horizontal: 12),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We Like to hear from our users!",style: largeTextStyle(),),
                      SizedBox(height: 8,),
                      Text("Tell us what you like or do not like about the Ssential Health App. We real all feedback,but we ain't able to respond to comments individually because they are overwhelming.",style: mediumTextStyle(),),
                      SizedBox(height: 8,),
                      Text("For the Medical questions,please contact your health care provider/facility directly.",style: mediumTextStyle(),),
                      Divider(color: Color(0xFFC6C6C6)),
                      FeedbackItems(
                        text: "Send App Feedback",
                        press: (){
                          _showAlert(context,"Send App Feedback");
                        },
                      ),
                      Divider(color: Color(0xFFC6C6C6)),
                      FeedbackItems(
                        text: "Report a bug",
                        press: (){
                          _showAlert(context,"Report a Bug");

                        },

                      ),
                      Divider(color: Color(0xFFC6C6C6)),
                      FeedbackItems(
                        text: "Rate this App",
                        press: (){},
                      ),
                      Divider(color: Color(0xFFC6C6C6)),


                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical:34.0),
                    child: Text("Version 1.0.0",style: mediumTextStyle(),),
                  ),

                ],
              ),

            ),

          ),
        ),
      ),
    );
  }

  void _showAlert(context,String title) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 270,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
             Row(
              children: <Widget>[
                 Container(
                  // padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  child: new Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // dialog centre
            SizedBox(height: 10,),
            Container(
                 child: Column(
                   children: [
                     new TextField(
                       decoration: textFieldInputDecoration("Email Address")
                     ),
                     SizedBox(height: 8,),
                     SingleChildScrollView(
                       reverse: true,
                       scrollDirection: Axis.vertical,
                       child: TextField(
                         maxLines: 5,
                         keyboardType: TextInputType.multiline,
                         decoration: textFieldInputDecoration("Write Review")
                       ),
                     ),
                   ],
                 ),
             ),
              SizedBox(height: 12,),
            // dialog bottom
              Container(
               alignment: Alignment.bottomCenter,
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(
                color: const Color(0xff163C4D),
              ),
              child: new Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'helvetica_neue_light',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return dialog;
        }
    );

  }

}



