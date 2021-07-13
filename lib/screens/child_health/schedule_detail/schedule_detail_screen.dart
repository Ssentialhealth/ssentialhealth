import 'package:flutter/material.dart';
import 'package:pocket_health/screens/child_health/schedule_detail/schedule_detail_data.dart';

class ScheduleDetailScreen extends StatefulWidget {
  final id;

  const ScheduleDetailScreen({Key key, this.id}) : super(key: key);

  @override
  _ScheduleDetailScreenState createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text(
          "Immunization Schedule",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ScheduleDetailData(id: widget.id),
      ),
    );
  }
}
