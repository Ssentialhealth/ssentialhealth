import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/doctor_consult/doctor_consult.dart';
import 'package:pocket_health/utils/constants.dart';

class NutritionPhysicalWellness extends StatefulWidget {
  const NutritionPhysicalWellness({Key key}) : super(key: key);

  @override
  _NutritionPhysicalWellnessState createState() => _NutritionPhysicalWellnessState();
}

class _NutritionPhysicalWellnessState extends State<NutritionPhysicalWellness> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                elevation: 0.0,
                title: Text(
                  "Nutrition and physical wellness",
                  style: appBarStyle,
                ),
                backgroundColor: Color(0xFF00FFFF),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeaderDelegate(
                  widget: Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: accentColorDark,
                      focusColor: Colors.transparent,
                    ),
                    child: TabBar(
                      isScrollable: false,
                      onTap: (idx) async {
                        if (idx == 1) {}
                      },
                      indicatorWeight: 2,
                      overlayColor: MaterialStateProperty.all(Colors.white),
                      indicatorColor: accentColorDark,
                      labelPadding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: accentColorDark,
                      unselectedLabelColor: Colors.black45,
                      controller: _tabController,
                      labelStyle: TextStyle(
                        color: accentColorDark,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        Tab(
                          text: 'Nutrition',
                        ),
                        Tab(
                          text: 'Wellness',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  Text(
                    'a',
                    style: TextStyle(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'a',
                    style: TextStyle(),
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
