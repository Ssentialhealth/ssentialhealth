part of 'fetch_facility_call_history_cubit.dart';

abstract class FetchFacilityCallHistoryState extends Equatable {
  const FetchFacilityCallHistoryState();
}

class FetchFacilityCallHistoryInitial extends FetchFacilityCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchFacilityCallHistoryLoading extends FetchFacilityCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchFacilityCallHistoryFailure extends FetchFacilityCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchFacilityCallHistorySuccess extends FetchFacilityCallHistoryState {
  final List<FacilityProfileModel> allFacilitiesCalled;
  final List<FacilityCallHistoryModel> allCallHistory;

  FetchFacilityCallHistorySuccess(this.allFacilitiesCalled, this.allCallHistory);

  @override
  List<Object> get props => [allFacilitiesCalled, allCallHistory];
}
