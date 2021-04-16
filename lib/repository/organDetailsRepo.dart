import 'package:pocket_health/models/organDetailsModel.dart';
import 'package:pocket_health/services/api_service.dart';

class OrganDetailsRepo{
  final ApiService apiService;
  OrganDetailsRepo(this.apiService) : assert(apiService != null);

  Future<OrganDetailsModel> getOrganDetails(int id)async{
    return await apiService.fetchOrganDetails(id);
  }
}