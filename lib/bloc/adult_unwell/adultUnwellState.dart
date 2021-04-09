import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/adult_unwell_model.dart';

abstract class AdultUnwellState extends Equatable{
  const AdultUnwellState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class  AdultUnwellInitial extends AdultUnwellState {}

class  AdultUnwellLoading extends AdultUnwellState {}

class  AdultUnwellError extends AdultUnwellState {}

class  AdultUnwellEmpty extends AdultUnwellState {}

class  AdultUnwellLoaded extends AdultUnwellState {
  final List<AdultUnwellModel> adultUnwellModel;
  @override
  List<AdultUnwellModel> get props => [];

  AdultUnwellLoaded(this.adultUnwellModel) : assert(adultUnwellModel != null);

}