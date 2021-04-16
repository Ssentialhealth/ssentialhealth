import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/models/organDetailsModel.dart';

abstract class OrganDetailsState extends Equatable{
  const OrganDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrganDetailsInitial extends OrganDetailsState {}

class OrganDetailsLoading extends OrganDetailsState {}

class OrganDetailsError extends OrganDetailsState {}

class OrganDetailsEmpty extends OrganDetailsState {}

class OrganDetailsLoaded extends OrganDetailsState {
  final OrganDetailsModel organDetailsModel;
  @override
  List<OrganDetailsModel> get props => [organDetailsModel];

  OrganDetailsLoaded(this.organDetailsModel) : assert(organDetailsModel != null);
}