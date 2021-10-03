import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/repository/mental_health_resources_service.dart';
import 'package:pocket_health/screens/pregnancy_lactation/widgets/contact_card.dart';
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
                final contactResources = resources?.where((element) => !element.information.contains("http"))?.toList();
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
                    ContactCard(),
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
