import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/delayed_milestone_model.dart';
import 'package:pocket_health/models/growth_chart_model.dart';


abstract class DelayedMilestoneState extends Equatable{
  const DelayedMilestoneState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  DelayedMilestoneInitial extends DelayedMilestoneState {}

class  DelayedMilestoneLoading extends DelayedMilestoneState {}

class  DelayedMilestoneError extends DelayedMilestoneState {}

class  DelayedMilestoneEmpty extends DelayedMilestoneState {}

class  DelayedMilestoneLoaded extends DelayedMilestoneState {
  final DelayedMilestoneModel delayedMilestoneModel;
  @override
  List<DelayedMilestoneModel> get props => [];

  DelayedMilestoneLoaded(this.delayedMilestoneModel) : assert(delayedMilestoneModel != null);

}