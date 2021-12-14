import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/health_insurance/list_insurances_page.dart';
import 'package:pocket_health/utils/constants.dart';

class InsuranceCategoriesScreen extends StatelessWidget {
  final List<String> items = [
    "Shop and compare Health Insurances",
    "Talk to agents",
    "Documents",
    "Pay Premium",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Health Insurances',
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //list of sub sections
            ...List.generate(
              items.length,
              (index) => Column(
                children: [
                  //tile
                  ListTile(
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xff00FFFF),
                    ),
                    title: Text(
                      items[index],
                      style: listTileTitleStyle,
                    ),
                    onTap: () {
                      if (index == 0)
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ListInsurancesPage();
                            },
                          ),
                        );
                    },
                  ),

                  //divider
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Divider(
                      height: 0,
                      thickness: 0.0,
                      color: Color(0xffC6C6C6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
