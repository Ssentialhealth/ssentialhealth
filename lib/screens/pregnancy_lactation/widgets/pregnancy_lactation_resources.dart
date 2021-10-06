import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_health/models/pregnancy_lactation_resources_model.dart';
import 'package:pocket_health/screens/emergency_screens/sexual_reproduction_screen.dart';
import 'package:pocket_health/utils/constants.dart';

import 'link_card.dart';

class PregnancyLactationResources extends StatelessWidget {
  const PregnancyLactationResources({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Pregnancy or Lactation resources",
            style: appBarStyle,
          ),
          backgroundColor: Color(0xFF00FFFF),
        ),
        body: SingleChildScrollView(
          child: Consumer(
            builder: (context, ScopedReader watch, child) {
              final resourcesAsyncVal = watch(pregnancyLactationResourcesModelFutureProvider);
              return resourcesAsyncVal.when(
                data: (resources) {
                  final pregLinkResources = resources.where((element) => element.information.contains("http")).toList();

                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: pregLinkResources.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final pregLinkResource = pregLinkResources[index];
                          return LinkCard(from: "preg", pregLinkResource: pregLinkResource);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SexualReproduction(),
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
                loading: () => Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (err, stack) {
                  print('--------|stack|--------|value -> ${stack.toString()}');

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
        ),
      ),
    );
  }
}
