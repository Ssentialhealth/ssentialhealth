import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/screens/mental_health/mental_health_conditions_page.dart';
import 'package:pocket_health/utils/constants.dart';

class MentalHealthOverviewPage extends StatelessWidget {
  const MentalHealthOverviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> listedConditions = [
      "Conditions relating to mood like bipolar, mania, depression",
      "Conditions relating to anxiety like phobias, social anxiety",
      "Conditions relating to perception like schizophrenia",
      "Conditions relating to habits like narcissism and OCPD",
      "Conditions relating to dependency on drugs like opioid dependency",
      "Conditions relating to eating like anorexia and bulimia",
      "Disorders relating to experienced trauma like PTSD",
      "Disorders relating to sleep like insomnia",
      "Disorders relating to physical symptoms without explainable physical causes (Somatic symptom disorder) like panic disorder, pain disorder",
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Mental Health and Conditions Overview",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            ExpandableNotifier(
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  iconColor: accentColor,
                  useInkWell: false,
                  tapHeaderToExpand: true,
                  hasIcon: false,
                  tapBodyToExpand: false,
                  tapBodyToCollapse: false,
                ),
                collapsed: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 354.w,
                        child: Text(
                          "In an ever-changing world, we are becoming more in tune with our mental health, recognizing the valueour thoughts and feelings play in shaping our lives and interactions. It can actually be argued that, thisfundamentally forms the core upon which our individuality and health is grounded.The mind literally is the core of the body, running every aspect of it, so if we jeopardize our mentalhealth then every other aspect of health is jeopardized.Our mental health is a product of nature and nurture, with the society having a huge role in this regard.What institutes mental health and what institutes being mentally unwell?We are all in a state of active, sometimes dynamic, thoughts, feelings and behaviour, at an individualand at a societal level, with all three aspects in constant action and interaction. Naturally therefore, weare all in a state of quiet disharmony as functional beings, giving rise to conflict within ourselves and orwith the society. Mostly, the mind tries to rationalize this conflict by equating it to various small goalsand milestones with short and long reward loops quelling the conflict and the existential crisis.However, some times, the mind is unable to rationalize and find harmony - as a factor of our nature as aa person and a factor of the happenings in our environment, referred to as nurture. This, disharmonytranslates to states of anger, sadness, hopelessness, doubt, anxiety, agitation, and so forth, which isnormal in short instances. These though may carry on for prolonged durations or become recurrent,making us in a constant state of conflict, or drive us to hurtful behavior and patterns, signifying that wemay be mentally unwell and may be in need of a remedy, a balance.It is apparent that this balance point varies from person to person and the things that cause sadness,anger, agitation and such are unique to each person. This is mainly because our lived experiences aredifferent. In mental health, we seek at finding a wholesome remedy to an individual, recognizing their uniquecircumstances and challenges and tailoring the solution(s) to the individual.It is the one place where not one shoe fits all and solutions are multi-dimensional.As such, do not feel obliged that every form of therapy has to have a positive result on you, at times itwill not, it is okay to seek that optimal point and find therapy that you feel is working for you.Simply put, it can be said, sound mental health is finding a state of balance of kindness to yourself andyour society.",
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ExpandableButton(
                        child: Text(
                          'Read More',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                expanded: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 354.w,
                        child: Text(
                          "In an ever-changing world, we are becoming more in tune with our mental health, recognizing the valueour thoughts and feelings play in shaping our lives and interactions. It can actually be argued that, thisfundamentally forms the core upon which our individuality and health is grounded.The mind literally is the core of the body, running every aspect of it, so if we jeopardize our mentalhealth then every other aspect of health is jeopardized.Our mental health is a product of nature and nurture, with the society having a huge role in this regard.What institutes mental health and what institutes being mentally unwell?We are all in a state of active, sometimes dynamic, thoughts, feelings and behaviour, at an individualand at a societal level, with all three aspects in constant action and interaction. Naturally therefore, weare all in a state of quiet disharmony as functional beings, giving rise to conflict within ourselves and orwith the society. Mostly, the mind tries to rationalize this conflict by equating it to various small goalsand milestones with short and long reward loops quelling the conflict and the existential crisis.However, some times, the mind is unable to rationalize and find harmony - as a factor of our nature as aa person and a factor of the happenings in our environment, referred to as nurture. This, disharmonytranslates to states of anger, sadness, hopelessness, doubt, anxiety, agitation, and so forth, which isnormal in short instances. These though may carry on for prolonged durations or become recurrent,making us in a constant state of conflict, or drive us to hurtful behavior and patterns, signifying that wemay be mentally unwell and may be in need of a remedy, a balance.It is apparent that this balance point varies from person to person and the things that cause sadness,anger, agitation and such are unique to each person. This is mainly because our lived experiences aredifferent. In mental health, we seek at finding a wholesome remedy to an individual, recognizing their uniquecircumstances and challenges and tailoring the solution(s) to the individual.It is the one place where not one shoe fits all and solutions are multi-dimensional.As such, do not feel obliged that every form of therapy has to have a positive result on you, at times itwill not, it is okay to seek that optimal point and find therapy that you feel is working for you.Simply put, it can be said, sound mental health is finding a state of balance of kindness to yourself andyour society.",
                          softWrap: true,
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ExpandableButton(
                        child: Text(
                          'Collapse',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              child: Text(
                "Well so, in what ways can we be mentally unwell:",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 8.w);
              },
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              itemCount: listedConditions.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final listedCondition = listedConditions[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 360.w,
                      child: Text(
                        listedCondition,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10.h),
            Divider(color: Colors.black26, height: 2),
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              trailing: Icon(
                Icons.chevron_right,
                color: Color(0xff00FFFF),
              ),
              title: Text(
                'See the conditions listed above in detail',
                style: listTileTitleStyle,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MentalHealthConditionsPage(),
                  ),
                );
              },
            ),
            Divider(color: Colors.black26, height: 2),
          ],
        ),
      ),
    );
  }
}
