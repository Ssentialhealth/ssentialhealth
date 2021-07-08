import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/models/symptoms_detail_model.dart';

abstract class SymptomDetailsState extends Equatable{
  const SymptomDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SymptomDetailsInitial extends SymptomDetailsState {}

class SymptomDetailsLoading extends SymptomDetailsState {}

class SymptomDetailsError extends SymptomDetailsState {}

class SymptomDetailsEmpty extends SymptomDetailsState {}

class SymptomDetailsLoaded extends SymptomDetailsState {
  final SymptomDetail symptomDetail;
  @override
  List<SymptomDetail> get props => [symptomDetail];

  SymptomDetailsLoaded(this.symptomDetail) : assert(SymptomDetail != null);
}