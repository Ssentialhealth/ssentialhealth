import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/pregnancy_health_conditions_model.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/widget.dart';

class PregnancyConditionsDetails extends StatelessWidget {
  final PregnancyHealthConditionsModel condition;
  const PregnancyConditionsDetails({Key key, this.condition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          condition.name,
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Overview title

            SizedBox(height: 16.h),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //overview data
            Markdown(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              styleSheet: MarkdownStyleSheet(
                h2: simpleTextStyle(),
              ),
              data: condition.overview,
            ),

            //Medication
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Medication",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            //Medication List
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Markdown(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  styleSheet: MarkdownStyleSheet(h2: simpleTextStyle()),
                  data: "• " + condition.medications,
                ),
              ),
            ),

            //Treatment
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Treatment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Markdown(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              styleSheet: MarkdownStyleSheet(h2: simpleTextStyle()),
              data: condition.treatment,
            ),

            //Investigation
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Investigation",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Markdown(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              styleSheet: MarkdownStyleSheet(h2: simpleTextStyle()),
              data: condition.investigation,
            ),

            //Prevention
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Prevention",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "• " + condition.prevention,
              ),
            ),

            //Complications
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Complications",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  condition.complications,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
