import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    child: GestureDetector(onTap: () async {}, child: Icon(Icons.menu, size: 32.0)),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0.w),
                          child: AdultUnwellMenuItems(
                            text: "Runny Nose",
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
