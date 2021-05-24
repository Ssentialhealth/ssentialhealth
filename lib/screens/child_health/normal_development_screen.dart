import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/child_health/normal_development_data.dart';
import 'package:pocket_health/widgets/widget.dart';


class NormalDevelopmentScreen extends StatefulWidget {
  const NormalDevelopmentScreen({Key key}) : super(key: key);

  @override
  _NormalDevelopmentScreenState createState() => _NormalDevelopmentScreenState();
}

class _NormalDevelopmentScreenState extends State<NormalDevelopmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FFFF),
      appBar: AppBar(
        title: Text("Normal Development Milestones",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NormalDevelopmentData(),
          ],
        ),
      ),
    );

  }
}
