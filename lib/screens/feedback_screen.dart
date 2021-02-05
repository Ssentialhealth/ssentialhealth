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
      body: Padding(
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
                      press: (){},
                    ),
                    Divider(color: Color(0xFFC6C6C6)),
                    FeedbackItems(
                      text: "Report a bug",
                      press: (){},
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
    );
  }
}
