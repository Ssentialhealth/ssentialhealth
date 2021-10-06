import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/models/pregnancy_health_conditions_model.dart';
import 'package:pocket_health/screens/adultUnwell/organs/organs.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/pregnancy_conditions_details.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnwellPregnancyLactation extends StatefulWidget {
  const UnwellPregnancyLactation({Key key}) : super(key: key);

  @override
  _UnwellPregnancyLactationState createState() => _UnwellPregnancyLactationState();
}

class _UnwellPregnancyLactationState extends State<UnwellPregnancyLactation> {
  String searchQuery = "";
  List<PregnancyHealthConditionsModel> queriedConditions = [];
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
              //conditions
              Consumer(
                builder: (context, ScopedReader watch, child) {
                  final pregnancyHealthConditionsAsyncVal = watch(pregnancyHealthConditionsModelProvider);
                  return pregnancyHealthConditionsAsyncVal.when(
                    data: (conditions) {
                      return Column(
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
                                        setState(() {
                                          searchQuery = val.toLowerCase();
                                          queriedConditions = conditions.where((element) => element.name.contains(searchQuery)).toList();
                                        });
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
                              //search
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Organs(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.menu,
                                    size: 32.0,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: queriedConditions.isEmpty ? conditions.length : queriedConditions.length,
                            itemBuilder: (BuildContext context, int index) {
                              final condition = queriedConditions.isEmpty ? conditions[index] : queriedConditions[index];
                              return GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  final bool pregnancyIsAgreed = prefs.getBool("pregnancyIsAgreed");
                                  final newVal = pregnancyIsAgreed == null ? await prefs.setBool("pregnancyIsAgreed", false) : pregnancyIsAgreed;

                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return PregnancyConditionsDetails(
                                        condition: condition,
                                        disclaimer: newVal,
                                      );
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
                          ),
                        ],
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
