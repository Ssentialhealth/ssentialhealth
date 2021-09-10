import 'package:pocket_health/models/facility_review_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FacilityReviewsRepo {
  final ApiService apiService;

  FacilityReviewsRepo(this.apiService) : assert(apiService != null);

  Future<FacilityReviewModel> addReview(reviewModel) async {
    return await apiService.postFacilityReview(reviewModel);
  }

  Future<List<FacilityReviewModel>> getReviews() async {
    return await apiService.fetchFacilityReviews();
  }
}
