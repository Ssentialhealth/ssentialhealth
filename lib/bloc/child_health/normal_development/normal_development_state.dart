import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/normal_development_Model.dart';
import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/models/symptom_model.dart';

abstract class NormalDevelopmentState extends Equatable{
  const NormalDevelopmentState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  NormalDevelopmentInitial extends NormalDevelopmentState {}

class  NormalDevelopmentLoading extends NormalDevelopmentState {}

class  NormalDevelopmentError extends NormalDevelopmentState {}

class  NormalDevelopmentEmpty extends NormalDevelopmentState {}

class  NormalDevelopmentLoaded extends NormalDevelopmentState {
  final NormalDevelopmentModel normalDevelopmentModel;
  @override
  List<NutritionModel> get props => [];

  NormalDevelopmentLoaded(this.normalDevelopmentModel) : assert(normalDevelopmentModel != null);

}