import 'package:flutter/material.dart';
import 'package:pocket_health/utils/constants.dart';

import 'contact_card.dart';
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
          child: Column(
            children: [
              LinkCard(),
              ContactCard(),
            ],
          ),
        ),
      ),
    );
  }
}
