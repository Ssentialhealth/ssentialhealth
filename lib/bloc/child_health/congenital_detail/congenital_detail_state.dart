import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/child_chronic_detail_model.dart';
import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/hotlines.dart';

abstract class CongenitalConditionDetailsState extends Equatable{
  const CongenitalConditionDetailsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CongenitalConditionDetailsInitial extends CongenitalConditionDetailsState {}

class CongenitalConditionDetailsLoading extends CongenitalConditionDetailsState {}

class CongenitalConditionDetailsError extends CongenitalConditionDetailsState {}

class CongenitalConditionDetailsEmpty extends CongenitalConditionDetailsState {}

class CongenitalConditionDetailsLoaded extends CongenitalConditionDetailsState {
  final CongenitalDetailModel congenitalDetailModel;
  @override
  List<CongenitalDetailModel> get props => [congenitalDetailModel];

  CongenitalConditionDetailsLoaded(this.congenitalDetailModel) : assert(congenitalDetailModel != null);
}