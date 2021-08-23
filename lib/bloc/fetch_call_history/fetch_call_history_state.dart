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
  final List<PractitionerProfileModel> allDoctorsCalled;

  FetchCallHistorySuccess(this.allDoctorsCalled);

  @override
  List<Object> get props => [allDoctorsCalled];
}
