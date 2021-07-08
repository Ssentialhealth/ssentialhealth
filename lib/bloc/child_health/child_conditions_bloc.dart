import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/child_conditions_model.dart';
import 'package:pocket_health/repository/child_conditions_repo.dart';
import 'child_conditions_event.dart';
import 'child_conditions_state.dart';



class ChildConditionBloc extends Bloc<ChildConditionEvent,ChildConditionState>{
  final ChildConditionsRepo childConditionsRepo;
  ChildConditionBloc({@required this.childConditionsRepo}) : super(ChildConditionInitial()){
    add(FetchChildConditions());
  }

  ChildConditionState get initialState => ChildConditionInitial();

  @override
  Stream<ChildConditionState> mapEventToState(
      ChildConditionEvent event
      ) async*{
    if(event is FetchChildConditions){
      yield ChildConditionLoading();
      try{
        final List<ChildConditionsModel> childConditionsModel = await childConditionsRepo.getChildConditions();
        yield ChildConditionLoaded(childConditionsModel);
      }catch(e){
        yield ChildConditionError();
        print(e.toString());
      }
    }
  }

}