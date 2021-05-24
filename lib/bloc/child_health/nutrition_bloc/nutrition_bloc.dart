import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/repository/nutrition_repo.dart';
import 'nutrition_event.dart';
import 'nutrition_state.dart';



class NutritionBloc extends Bloc<NutritionEvent,NutritionState>{
  final NutritionRepo nutritionRepo;
  NutritionBloc({@required this.nutritionRepo}) : super(NutritionInitial()){
    add(FetchNutrition());
  }

  NutritionState get initialState => NutritionInitial();

  @override
  Stream<NutritionState> mapEventToState(
      NutritionEvent event
      ) async*{
    if(event is FetchNutrition){
      yield NutritionLoading();
      try{
        final List<NutritionModel> nutritionModel = await nutritionRepo.getNutrition();
        yield NutritionLoaded(nutritionModel);
      }catch(e){
        yield NutritionError();
        print(e.toString());
      }
    }
  }

}