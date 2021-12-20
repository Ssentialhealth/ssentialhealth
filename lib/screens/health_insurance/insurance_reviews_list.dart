import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/insurance_review_model.dart';

import 'insurance_review_card.dart';

class InsuranceReviewsList extends StatelessWidget {
  final List<InsuranceReviewModel> sortedBy;

  const InsuranceReviewsList(this.sortedBy);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedBy.length,
      itemBuilder: (context, index) {
        final review = sortedBy[index];
        return InsuranceReviewCard(review: review);
      },
    );
  }
}
