import 'package:pocket_health/models/agent_call_history_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AgentCallHistoryRepo {
  final ApiService apiService;

  AgentCallHistoryRepo(this.apiService);

  Future<AgentCallHistoryModel> registerAgentCallHistory(Map<String, dynamic> mapData) async {
    return await apiService.addAgentCallHistoryToDB(mapData);
  }
}
