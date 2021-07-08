import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/normal_development_Model.dart';
import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/repository/normal_development_repo.dart';
import 'package:pocket_health/repository/nutrition_repo.dart';

import 'normal_development_event.dart';
import 'normal_development_state.dart';



class NormalDevelopmentBloc extends Bloc<NormalDevelopmentEvent,NormalDevelopmentState>{
  final NormalDevelopmentRepo normalDevelopmentRepo;
  NormalDevelopmentBloc({@required this.normalDevelopmentRepo}) : super(NormalDevelopmentInitial()){
    add(FetchNormalDevelopment());
  }

  NormalDevelopmentState get initialState => NormalDevelopmentInitial();

  @override
  Stream<NormalDevelopmentState> mapEventToState(
      NormalDevelopmentEvent event
      ) async*{
    if(event is FetchNormalDevelopment){
      yield NormalDevelopmentLoading();
      try{
        final NormalDevelopmentModel normalDevelopmentModel = await normalDevelopmentRepo.getNormalDevelopment();
        yield NormalDevelopmentLoaded(normalDevelopmentModel);
      }catch(e){
        yield NormalDevelopmentError();
        print(e.toString());
      }
    }
  }

}