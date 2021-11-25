import 'package:pocket_health/models/insurance_review_model.dart';
import 'package:pocket_health/services/api_service.dart';

class InsuranceReviewsRepo {
  final ApiService apiService;

  InsuranceReviewsRepo(this.apiService) : assert(apiService != null);

  Future<InsuranceReviewModel> addReview(reviewModel) async {
    return await apiService.postInsuranceReview(reviewModel);
  }

  Future<List<InsuranceReviewModel>> getReviews() async {
    return await apiService.fetchInsuranceReviews();
  }
}
