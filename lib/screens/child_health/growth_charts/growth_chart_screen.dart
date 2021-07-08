import 'package:flutter/material.dart';
import 'package:pocket_health/screens/child_health/growth_charts/growth_chart_data.dart';

class GrowthChartScreen extends StatefulWidget {
  const GrowthChartScreen({Key key}) : super(key: key);

  @override
  _GrowthChartScreenState createState() => _GrowthChartScreenState();
}

class _GrowthChartScreenState extends State<GrowthChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Growth Tables & Charts",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GrowthChartData(),
          ],
        ),
      ),
    );
  }
}
