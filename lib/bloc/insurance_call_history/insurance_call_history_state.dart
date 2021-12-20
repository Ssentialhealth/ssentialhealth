part of 'insurance_call_history_cubit.dart';

abstract class InsuranceCallHistoryState extends Equatable {
  const InsuranceCallHistoryState();
}

class InsuranceCallHistoryInitial extends InsuranceCallHistoryState {
  @override
  List<Object> get props => [];
}

class InsuranceCallHistoryLoading extends InsuranceCallHistoryState {
  @override
  List<Object> get props => [];
}

class InsuranceCallHistorySuccess extends InsuranceCallHistoryState {
  final InsuranceCallHistoryModel addedCall;

  InsuranceCallHistorySuccess(this.addedCall);

  @override
  List<Object> get props => [];
}

class InsuranceCallHistoryFailure extends InsuranceCallHistoryState {
  @override
  List<Object> get props => [];
}
