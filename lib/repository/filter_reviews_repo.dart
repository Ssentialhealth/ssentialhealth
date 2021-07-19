import 'dart:async';

import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FilterReviewsRepo {
  final ApiService apiService;

  FilterReviewsRepo(this.apiService) : assert(apiService != null);

  Future<List<ReviewModel>> getFilteredReviews({String filterBy}) async {
    // return apiService.;fetchFilteredReviews(filterBy:filterBy);
  }
}
