import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/services/api_service.dart';

class HotlineRepo{
  final ApiService apiService;
  HotlineRepo(this.apiService) : assert(apiService != null);

  Future<Hotlines> getHotlines(String country) async {
    return await apiService.fetchHotlines(country);
  }

}