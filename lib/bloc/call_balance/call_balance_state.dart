part of 'call_balance_cubit.dart';

abstract class CallBalanceState extends Equatable {
  const CallBalanceState();
}

class CallBalanceInitial extends CallBalanceState {
  @override
  List<Object> get props => [];
}

class CallBalanceLoading extends CallBalanceState {
  @override
  List<Object> get props => [];
}

class CallBalanceFailure extends CallBalanceState {
  @override
  List<Object> get props => [];
}

class CallBalanceFetchSuccess extends CallBalanceState {
  final CallBalanceModel callBalanceModel;

  CallBalanceFetchSuccess(this.callBalanceModel);

  @override
  List<Object> get props => [callBalanceModel];
}

class CallBalanceAddSuccess extends CallBalanceState {
  final CallBalanceModel callBalanceModel;

  CallBalanceAddSuccess(this.callBalanceModel);

  @override
  List<Object> get props => [callBalanceModel];
}
