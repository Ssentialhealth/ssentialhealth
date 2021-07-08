import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/models/symptom_model.dart';

abstract class NutritionState extends Equatable{
  const NutritionState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  NutritionInitial extends NutritionState {}

class  NutritionLoading extends NutritionState {}

class  NutritionError extends NutritionState {}

class  NutritionEmpty extends NutritionState {}

class  NutritionLoaded extends NutritionState {
  final List<NutritionModel> nutritionModel;
  @override
  List<NutritionModel> get props => [];

  NutritionLoaded(this.nutritionModel) : assert(nutritionModel != null);

}