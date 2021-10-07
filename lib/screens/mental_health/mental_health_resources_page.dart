import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/repository/mental_health_resources_service.dart';
import 'package:pocket_health/screens/emergency_screens/suicide_mental_screen.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/link_card.dart';
import 'package:pocket_health/utils/constants.dart';

import 'mental_health_resources_model.dart';

class MentalHealthResourcesPage extends StatelessWidget {
  const MentalHealthResourcesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Mental Health Resources",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ScopedReader watch, child) {
            final mentalHealthResourcesAsyncVal = watch(mentalHealthResourcesModelFutureProvider);
            return mentalHealthResourcesAsyncVal.when(
              data: (resources) {
                final linkResources = resources?.where((element) => element.information.contains("http"))?.toList();
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: linkResources?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final linkResource = linkResources.isNotEmpty ? linkResources[index] : [MentalHealthResourcesService()];
                        return LinkCard(mentalLinkResource: linkResource);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SuicideMental(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 306,
                              child: Text(
                                "Hotline and Support Organisations",
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: accentColorDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => Padding(
                padding: EdgeInsets.all(8.w),
                child: Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              error: (err, stack) {
                print('--------|stack|--------|value -> ${stack.toString()}');
                return Container(
                  color: Colors.red,
                  width: 100,
                  height: 200,
                  child: Text(
                    err.toString(),
                    style: TextStyle(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
