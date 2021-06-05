import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/growth_chart_model.dart';


abstract class GrowthChartState extends Equatable{
  const GrowthChartState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  GrowthChartInitial extends GrowthChartState {}

class  GrowthChartLoading extends GrowthChartState {}

class  GrowthChartError extends GrowthChartState {}

class  GrowthChartEmpty extends GrowthChartState {}

class  GrowthChartLoaded extends GrowthChartState {
  final GrowthChartModel growthChatModel;
  @override
  List<GrowthChartModel> get props => [];

  GrowthChartLoaded(this.growthChatModel) : assert(growthChatModel != null);

}