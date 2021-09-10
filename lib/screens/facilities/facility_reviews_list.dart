import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/facility_review_model.dart';

import 'facility_review_card.dart';

class FacilityReviewsList extends StatelessWidget {
  final List<FacilityReviewModel> sortedBy;

  const FacilityReviewsList(this.sortedBy);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedBy.length,
      itemBuilder: (context, index) {
        final review = sortedBy[index];
        return FacilityReviewCard(review: review);
      },
    );
  }
}
