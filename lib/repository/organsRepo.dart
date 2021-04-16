import 'package:pocket_health/models/adult_unwell_model.dart';
import 'package:pocket_health/models/organsModel.dart';
import 'package:pocket_health/services/api_service.dart';

class OrgansRepo{
  final ApiService apiService;
  OrgansRepo(this.apiService) : assert(apiService != null);

  Future<List<OrgansModel>> getOrgans() async {
    return await apiService.fetchAllOrgans();
  }
}