import 'package:equatable/equatable.dart';

abstract class GrowthChartEvent extends Equatable{
  const GrowthChartEvent();

  @override
  List<Object> get props => [];

}

class FetchGrowthCharts extends GrowthChartEvent {
  const FetchGrowthCharts();
}