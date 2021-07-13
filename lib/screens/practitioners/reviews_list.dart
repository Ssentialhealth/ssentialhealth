import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/screens/practitioners/review_card.dart';

class ReviewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ReviewCard();
      },
    );
  }
}
