import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/organsModel.dart';

abstract class OrgansState extends Equatable{
  const OrgansState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  OrgansInitial extends OrgansState {}

class  OrgansLoading extends OrgansState {}

class  OrgansError extends OrgansState {}

class  OrgansEmpty extends OrgansState {}

class  OrgansLoaded extends OrgansState {
  final List<OrgansModel> organsModel;
  @override
  List<OrgansModel> get props => [];

  OrgansLoaded(this.organsModel) : assert(organsModel != null);

}