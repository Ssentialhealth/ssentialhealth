part of 'fetch_insurance_call_history_cubit.dart';

abstract class FetchInsuranceCallHistoryState extends Equatable {
  const FetchInsuranceCallHistoryState();
}

class FetchInsuranceCallHistoryInitial extends FetchInsuranceCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchInsuranceCallHistoryLoading extends FetchInsuranceCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchInsuranceCallHistoryFailure extends FetchInsuranceCallHistoryState {
  @override
  List<Object> get props => [];
}

class FetchInsuranceCallHistorySuccess extends FetchInsuranceCallHistoryState {
  final List<HealthInsuranceModel> allInsurancesCalled;
  final List<InsuranceCallHistoryModel> allCallHistory;

  FetchInsuranceCallHistorySuccess(this.allInsurancesCalled, this.allCallHistory);

  @override
  List<Object> get props => [allInsurancesCalled, allCallHistory];
}
