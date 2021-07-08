import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_event.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_state.dart';
import 'package:pocket_health/models/children_resources_model.dart';
import 'package:pocket_health/repository/child_resource_repo.dart';



class ChildResourceBloc extends Bloc<ChildResourceEvent,ChildResourceState>{
  final ChildResourceRepo childResourceRepo;
  ChildResourceBloc({@required this.childResourceRepo}) : super(ChildResourceInitial()){
    add(FetchResource());
  }

  ChildResourceState get initialState => ChildResourceInitial();

  @override
  Stream<ChildResourceState> mapEventToState(
      ChildResourceEvent event
      ) async*{
    if(event is FetchResource){
      yield ChildResourceLoading();
      try{
        final List<ChildResourceModel> childResourceModel = await childResourceRepo.getResources();
        yield ChildResourceLoaded(childResourceModel);
      }catch(e){
        yield ChildResourceError();
        print(e.toString());
      }
    }
  }

}