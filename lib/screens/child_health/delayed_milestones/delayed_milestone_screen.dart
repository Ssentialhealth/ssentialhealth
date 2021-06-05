import 'package:flutter/material.dart';

import 'delayed_milestone_data.dart';

class DelayedMilestoneScreen extends StatefulWidget {
  const DelayedMilestoneScreen({Key key}) : super(key: key);

  @override
  _DelayedMilestoneScreenState createState() => _DelayedMilestoneScreenState();
}

class _DelayedMilestoneScreenState extends State<DelayedMilestoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Delayed Milestones",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DelayedMilestoneData(),
          ],
        ),
      ),
    );
  }
}
