import 'package:pocket_health/models/agent_review_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AgentReviewsRepo {
  final ApiService apiService;

  AgentReviewsRepo(this.apiService) : assert(apiService != null);

  Future<AgentReviewModel> addReview(reviewModel) async {
    return await apiService.postAgentReview(reviewModel);
  }

  Future<List<AgentReviewModel>> getReviews() async {
    return await apiService.fetchAgentReviews();
  }
}
