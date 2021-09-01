part of 'call_history_cubit.dart';

abstract class CallHistoryState extends Equatable {
  const CallHistoryState();
}

class CallHistoryInitial extends CallHistoryState {
  @override
  List<Object> get props => [];
}

class CallHistoryLoading extends CallHistoryState {
  @override
  List<Object> get props => [];
}

class CallHistoryFailure extends CallHistoryState {
  @override
  List<Object> get props => [];
}

class CallHistorySuccess extends CallHistoryState {
  final CallHistoryModel addedCall;

  CallHistorySuccess(this.addedCall);

  @override
  List<Object> get props => [addedCall];
}
