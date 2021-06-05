import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/delayed_milestone_model.dart';
import 'package:pocket_health/repository/delayed_milestones_repo.dart';
import 'delayed_milestone_state.dart';
import 'delayed_milestones_event.dart';


class DelayedMilestoneBloc extends Bloc<DelayedMilestoneEvent,DelayedMilestoneState>{
  final DelayedMilestonesRepo delayedMilestonesRepo;
  DelayedMilestoneBloc({@required this.delayedMilestonesRepo}) : super(DelayedMilestoneInitial()){
    add(FetchDelayedMilestones());
  }

  DelayedMilestoneState get initialState => DelayedMilestoneInitial();

  @override
  Stream<DelayedMilestoneState> mapEventToState(
      DelayedMilestoneEvent event
      ) async*{
    if(event is FetchDelayedMilestones){
      yield DelayedMilestoneLoading();
      try{
        final DelayedMilestoneModel delayedMilestones = await delayedMilestonesRepo.getDelayedMilestones();
        yield DelayedMilestoneLoaded(delayedMilestones);
      }catch(e){
        yield DelayedMilestoneError();
        print(e.toString());
      }
    }
  }

}