import 'package:pocket_health/models/agent_call_history_model.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/services/api_service.dart';

class FetchAgentCallHistoryRepo {
  final ApiService apiService;

  FetchAgentCallHistoryRepo(this.apiService);

  Future<List<InsuranceAgentModel>> getCallHistoryAgentDetails(userID) async {
    return await apiService.fetchAllAgentsCalled(userID);
  }

  Future<List<AgentCallHistoryModel>> getAllCallHistory(List<InsuranceAgentModel> allAgents, userID) async {
    final List<AgentCallHistoryModel> allCallHistory = await apiService.fetchAllAgentCallHistory(userID);

    Future<List<AgentCallHistoryModel>> getCallHistoryByAgentID() async {
      List<AgentCallHistoryModel> all = [];
      for (final agent in allAgents) {
        final history = allCallHistory.lastWhere((element) => element.agent == agent.id);
        print('--------|ended|--------|value -> ${history.endTime.toString()}');

        all.add(history);
      }
      // print('--------|all|--------|value -> ${all[0].user.toString()}');

      return all;
    }

    return await getCallHistoryByAgentID();
  }
}
