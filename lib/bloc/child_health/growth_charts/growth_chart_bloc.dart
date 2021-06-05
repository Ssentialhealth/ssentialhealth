import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/growth_chart_model.dart';
import 'package:pocket_health/repository/growth_charts_repo.dart';

import 'growth_chart_event.dart';
import 'growth_chart_state.dart';




class GrowthChartBloc extends Bloc<GrowthChartEvent,GrowthChartState>{
  final GrowthChartsRepo growthChartsRepo;
  GrowthChartBloc({@required this.growthChartsRepo}) : super(GrowthChartInitial()){
    add(FetchGrowthCharts());
  }

  GrowthChartState get initialState => GrowthChartInitial();

  @override
  Stream<GrowthChartState> mapEventToState(
      GrowthChartEvent event
      ) async*{
    if(event is FetchGrowthCharts){
      yield GrowthChartLoading();
      try{
        final GrowthChartModel growthChartModel = await growthChartsRepo.getGrowthCharts();
        yield GrowthChartLoaded(growthChartModel);
      }catch(e){
        yield GrowthChartError();
        print(e.toString());
      }
    }
  }

}