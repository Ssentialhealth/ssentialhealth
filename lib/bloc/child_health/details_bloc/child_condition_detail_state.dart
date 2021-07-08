import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/hotlines.dart';

abstract class ChildConditionDetailsState extends Equatable{
  const ChildConditionDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChildConditionDetailsInitial extends ChildConditionDetailsState {}

class ChildConditionDetailsLoading extends ChildConditionDetailsState {}

class ChildConditionDetailsError extends ChildConditionDetailsState {}

class ChildConditionDetailsEmpty extends ChildConditionDetailsState {}

class ChildConditionDetailsLoaded extends ChildConditionDetailsState {
  final ChildConditionsDetailModel childConditionsDetailModel;
  @override
  List<ChildConditionsDetailModel> get props => [childConditionsDetailModel];

  ChildConditionDetailsLoaded(this.childConditionsDetailModel) : assert(childConditionsDetailModel != null);
}