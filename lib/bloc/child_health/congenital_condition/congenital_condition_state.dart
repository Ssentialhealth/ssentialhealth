import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/child_chronic_condition_model.dart';
import 'package:pocket_health/models/child_conditions_model.dart';

abstract class CongenitalConditionState extends Equatable{
  const CongenitalConditionState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  CongenitalConditionInitial extends CongenitalConditionState {}

class  CongenitalConditionLoading extends CongenitalConditionState {}

class  CongenitalConditionError extends CongenitalConditionState {}

class  CongenitalConditionEmpty extends CongenitalConditionState {}

class  CongenitalConditionLoaded extends CongenitalConditionState {
  final List<CongenitalConditionsModel> congenitalConditionModel;
  @override
  List<CongenitalConditionsModel> get props => [];

  CongenitalConditionLoaded(this.congenitalConditionModel) : assert(congenitalConditionModel != null);

}