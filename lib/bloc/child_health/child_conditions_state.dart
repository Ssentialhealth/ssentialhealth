import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/child_conditions_model.dart';

abstract class ChildConditionState extends Equatable{
  const ChildConditionState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  ChildConditionInitial extends ChildConditionState {}

class  ChildConditionLoading extends ChildConditionState {}

class  ChildConditionError extends ChildConditionState {}

class  ChildConditionEmpty extends ChildConditionState {}

class  ChildConditionLoaded extends ChildConditionState {
  final List<ChildConditionsModel> childConditionModel;
  @override
  List<ChildConditionsModel> get props => [];

  ChildConditionLoaded(this.childConditionModel) : assert(childConditionModel != null);

}