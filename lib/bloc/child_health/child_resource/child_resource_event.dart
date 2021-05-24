import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/adult_unwell_model.dart';
import 'package:pocket_health/models/children_resources_model.dart';
import 'package:pocket_health/models/symptom_model.dart';

abstract class ChildResourceState extends Equatable{
  const ChildResourceState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  ChildResourceInitial extends ChildResourceState {}

class  ChildResourceLoading extends ChildResourceState {}

class  ChildResourceError extends ChildResourceState {}

class  ChildResourceEmpty extends ChildResourceState {}

class  ChildResourceLoaded extends ChildResourceState {
  final List<ChildResourceModel> childResourceModel;
  @override
  List<ChildResourceModel> get props => [];

  ChildResourceLoaded(this.childResourceModel) : assert(childResourceModel != null);

}