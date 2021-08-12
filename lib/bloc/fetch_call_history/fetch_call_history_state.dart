part of 'fetch_call_history_cubit.dart';

abstract class FetchCallHistoryState extends Equatable {
  const FetchCallHistoryState();
}

class FetchCallHistoryInitial extends FetchCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchCallHistoryLoading extends FetchCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchCallHistoryFailure extends FetchCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchCallHistorySuccess extends FetchCallHistoryState {
  final int totalTalkTime;
  final List<CallHistoryModel> allCallHistory;
  final List<PractitionerProfileModel> allDocDetails;

  FetchCallHistorySuccess(this.allCallHistory, this.totalTalkTime, this.allDocDetails);

  @override
  List<Object> get props => [allCallHistory, totalTalkTime, allDocDetails];
}
