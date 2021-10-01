import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/pregnancy_health_conditions_model.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/pregnancy_conditions_details.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';

class UnwellPregnancyLactation extends StatelessWidget {
  const UnwellPregnancyLactation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Unwell in Pregnancy or Lactation",
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //search
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: searchFieldInputDecoration("Search main symptom"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {},
                      child: Icon(
                        Icons.menu,
                        size: 32.0,
                      ),
                    ),
                  ),
                ],
              ),

              //conditions
              Consumer(
                builder: (context, ScopedReader watch, child) {
                  final pregnancyHealthConditionsAsyncVal = watch(pregnancyHealthConditionsModelProvider);
                  return pregnancyHealthConditionsAsyncVal.when(
                    data: (conditions) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: conditions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final condition = conditions[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return PregnancyConditionsDetails(condition: condition);
                                }),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: AdultUnwellMenuItems(
                                          text: condition.name,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    loading: () {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 24.w,
                            width: 24.w,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                    error: (err, stack) {
                      return Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                        child: Text(
                          err,
                          style: TextStyle(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
