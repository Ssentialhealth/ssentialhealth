part of 'facility_call_history_cubit.dart';

abstract class FacilityCallHistoryState extends Equatable {
  const FacilityCallHistoryState();
}

class FacilityCallHistoryInitial extends FacilityCallHistoryState {
  @override
  List<Object> get props => [];
}

class FacilityCallHistoryLoading extends FacilityCallHistoryState {
  @override
  List<Object> get props => [];
}

class FacilityCallHistorySuccess extends FacilityCallHistoryState {
  final FacilityCallHistoryModel addedCall;

  FacilityCallHistorySuccess(this.addedCall);

  @override
  List<Object> get props => [];
}

class FacilityCallHistoryFailure extends FacilityCallHistoryState {
  @override
  List<Object> get props => [];
}
