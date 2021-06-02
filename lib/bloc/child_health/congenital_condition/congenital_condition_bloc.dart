import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/child_chronic_condition_model.dart';
import 'package:pocket_health/repository/congenital_conditions_repo.dart';

import '../child_conditions_event.dart';
import 'congenital_condition_event.dart';
import 'congenital_condition_state.dart';


class CongenitalConditionBloc extends Bloc<CongenitalConditionEvent,CongenitalConditionState>{
  final CongenitalConditionsRepo congenitalConditionsRepo;
  CongenitalConditionBloc({@required this.congenitalConditionsRepo}) : super(CongenitalConditionInitial()){
    add(FetchCongenitalConditions());
  }

  CongenitalConditionState get initialState => CongenitalConditionInitial();

  @override
  Stream<CongenitalConditionState> mapEventToState(
      CongenitalConditionEvent event
      ) async*{
    if(event is FetchCongenitalConditions){
      yield CongenitalConditionLoading();
      try{
        final List<CongenitalConditionsModel> congenitalConditionsModel = await congenitalConditionsRepo.getCongenitalConditions();
        yield CongenitalConditionLoaded(congenitalConditionsModel);
      }catch(e){
        yield CongenitalConditionError();
        print(e.toString());
      }
    }
  }

}