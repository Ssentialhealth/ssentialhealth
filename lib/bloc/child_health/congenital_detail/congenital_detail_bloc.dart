import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/child_chronic_detail_model.dart';
import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/repository/child_condition_detail_repo.dart';
import 'package:pocket_health/repository/congenital_conditions_repo.dart';
import 'package:pocket_health/repository/congenital_details_repo.dart';

import 'congenital_detail_event.dart';
import 'congenital_detail_state.dart';


class CongenitalConditionDetailsBloc extends Bloc<CongenitalConditionDetailsEvent,CongenitalConditionDetailsState>{
  final CongenitalConditionDetailRepo congenitalDetailDetailRepo;
  CongenitalConditionDetailsBloc({@required this.congenitalDetailDetailRepo}) : super(CongenitalConditionDetailsInitial());

  CongenitalConditionDetailsState get initialState => CongenitalConditionDetailsInitial();

  @override
  Stream<CongenitalConditionDetailsState> mapEventToState(
      CongenitalConditionDetailsEvent event)async*{
    if(event is FetchCongenitalConditionDetails){
      yield CongenitalConditionDetailsLoading();
      try{
        final CongenitalDetailModel congenitalConditionsDetailModel = await congenitalDetailDetailRepo.getCongenitalConditionDetails(event.id);
        yield CongenitalConditionDetailsLoaded(congenitalConditionsDetailModel);
      }catch(e){
        yield CongenitalConditionDetailsError();
        print(e.toString());
      }
    }
  }
}