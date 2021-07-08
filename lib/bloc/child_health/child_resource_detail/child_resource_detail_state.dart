import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/child_resource_detail_model.dart';
import 'package:pocket_health/models/children_resources_model.dart';

abstract class ChildResourceDetailsState extends Equatable{
  const ChildResourceDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChildResourceDetailsInitial extends ChildResourceDetailsState {}

class ChildResourceDetailsLoading extends ChildResourceDetailsState {}

class ChildResourceDetailsError extends ChildResourceDetailsState {}

class ChildResourceDetailsEmpty extends ChildResourceDetailsState {}

class ChildResourceDetailsLoaded extends ChildResourceDetailsState {
  final ChildResourceDetailModel childResourcesDetailModel;
  @override
  List<ChildResourceDetailModel> get props => [childResourcesDetailModel];

  ChildResourceDetailsLoaded(this.childResourcesDetailModel) : assert(childResourcesDetailModel != null);
}