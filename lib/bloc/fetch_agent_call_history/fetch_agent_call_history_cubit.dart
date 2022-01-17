import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/agent_call_history_model.dart';
import 'package:pocket_health/repository/fetch_agent_call_history_repo.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';

part 'fetch_agent_call_history_state.dart';

class FetchAgentCallHistoryCubit extends Cubit<FetchAgentCallHistoryState> {
  final FetchAgentCallHistoryRepo fetchAgentCallHistoryRepo;

  FetchAgentCallHistoryCubit(this.fetchAgentCallHistoryRepo) : super(FetchAgentCallHistoryInitial());

  void getCallHistory(int userID) async {
    try {
      emit(FetchAgentCallHistoryLoading());
      final allAgentsCalled = await fetchAgentCallHistoryRepo.getCallHistoryAgentDetails(userID);
      final allAgentCallHistory = await fetchAgentCallHistoryRepo.getAllCallHistory(allAgentsCalled, userID);

      emit(FetchAgentCallHistorySuccess(allAgentsCalled, allAgentCallHistory));
    } catch (_, e) {
      emit(FetchAgentCallHistoryFailure());
      print("get agent call history failed | $e");
    }
  }
}
