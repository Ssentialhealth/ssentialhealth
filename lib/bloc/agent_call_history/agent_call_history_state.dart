part of 'agent_call_history_cubit.dart';

abstract class AgentCallHistoryState extends Equatable {
	const AgentCallHistoryState();
}

class AgentCallHistoryInitial extends AgentCallHistoryState {
	@override
	List<Object> get props => [];
}

class AgentCallHistoryLoading extends AgentCallHistoryState {
	@override
	List<Object> get props => [];
}

class AgentCallHistorySuccess extends AgentCallHistoryState {
	final AgentCallHistoryModel addedCall;

	AgentCallHistorySuccess(this.addedCall);

	@override
	List<Object> get props => [];
}

class AgentCallHistoryFailure extends AgentCallHistoryState {
	@override
	List<Object> get props => [];
}
