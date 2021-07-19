import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/screens/practitioners/review_card.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewModel> sortedBy;

  const ReviewsList(this.sortedBy);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedBy.length,
      itemBuilder: (context, index) {
        final review = sortedBy[index];
        return ReviewCard(review: review);
      },
    );
	}
}
