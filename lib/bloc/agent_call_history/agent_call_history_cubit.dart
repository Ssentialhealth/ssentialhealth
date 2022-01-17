import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/agent_call_history_model.dart';
import 'package:pocket_health/repository/agent_call_history_repo.dart';

part 'agent_call_history_state.dart';

class AgentCallHistoryCubit extends Cubit<AgentCallHistoryState> {
  final AgentCallHistoryRepo agentCallHistoryRepo;

  AgentCallHistoryCubit(this.agentCallHistoryRepo) : super(AgentCallHistoryInitial());

  void addCallHistory(int userID, int agentID, String startedAt, String endedAt) async {
    try {
      emit(AgentCallHistoryLoading());
      final Map<String, dynamic> mapData = {
        "startTime": startedAt,
        "endTime": endedAt,
        "duration": null,
        "user": userID,
        "agent": 2, //testing
      };

      final addedCall = await agentCallHistoryRepo.registerAgentCallHistory(mapData);

      emit(AgentCallHistorySuccess(addedCall));
    } catch (_) {
      emit(AgentCallHistoryFailure());
      print("add to call history failed | $_");
    }
  }
}
