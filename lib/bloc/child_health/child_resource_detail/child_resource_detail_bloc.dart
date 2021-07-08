import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/child_resource_detail_model.dart';
import 'package:pocket_health/repository/chilren_resource_detail_repo.dart';

import 'child_resource_detail_event.dart';
import 'child_resource_detail_state.dart';


class ChildResourceDetailsBloc extends Bloc<ChildResourceDetailsEvent,ChildResourceDetailsState>{
  final ChildResourceDetailRepo childResourceDetailRepo;
  ChildResourceDetailsBloc({@required this.childResourceDetailRepo}) : super(ChildResourceDetailsInitial());

  ChildResourceDetailsState get initialState => ChildResourceDetailsInitial();

  @override
  Stream<ChildResourceDetailsState> mapEventToState(
      ChildResourceDetailsEvent event)async*{
    if(event is FetchChildResourceDetails){
      yield ChildResourceDetailsLoading();
      try{
        final ChildResourceDetailModel childResourcesDetailModel = await childResourceDetailRepo.getResourceDetails(event.id);
        yield ChildResourceDetailsLoaded(childResourcesDetailModel);
      }catch(e){
        yield ChildResourceDetailsError();
        print(e.toString());
      }
    }
  }
}