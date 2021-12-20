import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/agent_review_model.dart';

import 'agent_review_card.dart';

class AgentReviewsList extends StatelessWidget {
  final List<AgentReviewModel> sortedBy;

  const AgentReviewsList(this.sortedBy);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedBy.length,
      itemBuilder: (context, index) {
        final review = sortedBy[index];
        return AgentReviewCard(review: review);
      },
    );
  }
}
