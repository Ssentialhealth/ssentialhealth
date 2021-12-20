part of 'fetch_agent_call_history_cubit.dart';

abstract class FetchAgentCallHistoryState extends Equatable {
  const FetchAgentCallHistoryState();
}

class FetchAgentCallHistoryInitial extends FetchAgentCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchAgentCallHistoryLoading extends FetchAgentCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchAgentCallHistoryFailure extends FetchAgentCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchAgentCallHistorySuccess extends FetchAgentCallHistoryState {
  final List<InsuranceAgentModel> allAgentsCalled;
  final List<AgentCallHistoryModel> allCallHistory;

  FetchAgentCallHistorySuccess(this.allAgentsCalled, this.allCallHistory);

  @override
  List<Object> get props => [allAgentsCalled, allCallHistory];
}
