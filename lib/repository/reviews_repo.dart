import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/services/api_service.dart';

class ReviewsRepo {
  final ApiService apiService;

  ReviewsRepo(this.apiService) : assert(apiService != null);

  Future<ReviewModel> addReview(reviewModel) async {
    return await apiService.postReview(reviewModel);
  }
}
