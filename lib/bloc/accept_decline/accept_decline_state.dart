part of 'accept_decline_cubit.dart';

abstract class AcceptDeclineState extends Equatable {
  const AcceptDeclineState();
}

class AcceptDeclineInitial extends AcceptDeclineState {
  @override
  List<Object> get props => [];
}

class AcceptDeclineLoading extends AcceptDeclineState {
  @override
  List<Object> get props => [];
}

class AcceptDeclineSuccess extends AcceptDeclineState {
  final AcceptDeclineModel booking;

  AcceptDeclineSuccess(this.booking);

  @override
  List<Object> get props => [booking];
}

class AcceptDeclineFailure extends AcceptDeclineState {
  @override
  List<Object> get props => [];
}
