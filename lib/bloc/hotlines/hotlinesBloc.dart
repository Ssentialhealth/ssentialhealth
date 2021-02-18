import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesEvent.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesState.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/repository/hotline_repo.dart';

class HotlinesBloc extends Bloc<HotlinesEvent,HotlineState>{
  final HotlineRepo hotlinesRepo;
  HotlinesBloc({@required this.hotlinesRepo}) : super(HotlinesInitial()){
    add(FetchHotline());
  }

  HotlineState get initialState => HotlinesInitial();

  @override
  Stream<HotlineState> mapEventToState(
      HotlinesEvent event
      ) async*{
    if(event is FetchHotline){
      yield HotlinesLoading();
      try{
        final List<Hotlines> hotlines = await hotlinesRepo.getHotlines();
        yield HotlinesLoaded(hotlines);
      }catch(_){
        yield HotlinesError();
      }
    }

  }
}