import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesEvent.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesState.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/repository/hotline_repo.dart';

class HotlinesBloc extends Bloc<HotlinesEvent,HotlineState>{
  final HotlineRepo hotlinesRepo;
  HotlinesBloc({@required this.hotlinesRepo}) : super(HotlinesInitial());

  HotlineState get initialState => HotlinesInitial();

  @override
  Stream<HotlineState> mapEventToState(
      HotlinesEvent event) async*{
    if(event is FetchHotline){
      yield HotlinesLoading();
      try{
        final Hotlines hotlines = await hotlinesRepo.getHotlines(event.country);
        yield HotlinesLoaded(hotlines);
      }catch(e){
        yield HotlinesError();
        print(e.toString());
      }
    }

  }
}