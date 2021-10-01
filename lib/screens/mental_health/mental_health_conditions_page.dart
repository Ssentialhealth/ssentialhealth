import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/models/mental_health_conditions_model.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mental_health_condition_details_screen.dart';

class MentalHealthConditionsPage extends StatefulWidget {
  final bool disclaimer;
  const MentalHealthConditionsPage({Key key, this.disclaimer}) : super(key: key);

  @override
  _MentalHealthConditionsPageState createState() => _MentalHealthConditionsPageState();
}

class _MentalHealthConditionsPageState extends State<MentalHealthConditionsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.disclaimer == false) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return MentalHealthDisclaimer();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Mental Health Conditions",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // search
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: SizedBox(
                      height: 40.h,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        onChanged: (val) async {
                          // setState(() {
                          //   searchQuery = val.toLowerCase();
                          //   filteredCategories = categories.where((element) => element.toLowerCase().contains(searchQuery)).toList();
                          // });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0.w),
                          hintText: "Search for Conditions",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                            borderSide: BorderSide(color: Color(0xFF00FFFF)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Consumer(
              builder: (context, ScopedReader watch, child) {
                final mentalHealthConditionsAsyncVal = watch(mentalHealthConditionsModelProvider);
                return mentalHealthConditionsAsyncVal.when(
                  data: (conditions) {
                    return ListView.builder(
                      itemCount: conditions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final condition = conditions[index];
                        return ListTile(
                          dense: true,
                          isThreeLine: false,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Color(0xff00FFFF),
                          ),
                          title: Text(
                            condition.overview.split(",").first,
                            style: listTileTitleStyle,
                          ),
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MentalHealthConditionDetailsScreen(
                                  condition: condition,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: Container(
                      height: 24.h,
                      width: 24.h,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (err, stack) {
                    print('--------|mental health err|--------|value -> ${stack.toString()}');
                    return Container(color: Colors.red, width: 200, height: 100);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MentalHealthDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.w),
              child: Text(
                "This information is to aid in understanding pregnancy health and does not constitute medical advice.. Please consult doctor or seek care (facilities) if currently unwell. The content in this section refer to persons who are pregnant. If not pregnant, refer to Adult Unwell  or Unwell Child sections.",
                maxLines: 6,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: textBlack,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //cancel
                Spacer(),
                TextButton(
                  child: Text(
                    'BACK',
                    style: TextStyle(
                      color: accentColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size(0, 0)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    )),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MentalHealthConditionsPage(),
                      ),
                    );
                  },
                ),

                SizedBox(width: 8.w),
                //post
                TextButton(
                  child: Text(
                    'AGREE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                    minimumSize: MaterialStateProperty.all(Size(0, 0)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                      side: BorderSide(
                        color: Color(0xff1A5864),
                        width: 1.w,
                      ),
                    )),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.getBool("mentalHealthIsAgreed") != true ? prefs.setBool('mentalHealthIsAgreed', true) : null;
                    final test = prefs.getBool('mentalHealthIsAgreed');
                    print('test' + test.toString());
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
