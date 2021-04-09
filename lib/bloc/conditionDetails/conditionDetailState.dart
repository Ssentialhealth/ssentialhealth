import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/hotlines.dart';

abstract class ConditionDetailsState extends Equatable{
  const ConditionDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ConditionDetailsInitial extends ConditionDetailsState {}

class ConditionDetailsLoading extends ConditionDetailsState {}

class ConditionDetailsError extends ConditionDetailsState {}

class ConditionDetailsEmpty extends ConditionDetailsState {}

class ConditionDetailsLoaded extends ConditionDetailsState {
  final ConditionDetails conditionDetails;
  @override
  List<ConditionDetails> get props => [conditionDetails];

  ConditionDetailsLoaded(this.conditionDetails) : assert(ConditionDetails != null);
}