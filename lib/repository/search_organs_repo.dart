import 'package:pocket_health/models/organs_search_model.dart';
import 'package:pocket_health/services/api_service.dart';

class SearchOrganRepo {
  final ApiService apiService;

  SearchOrganRepo(this.apiService) : assert(apiService != null);

  Future<List<SearchOrgan>> getOrgan(String organ) async {
    return await apiService.fetchSearchedOrgan(organ);
  }
}
