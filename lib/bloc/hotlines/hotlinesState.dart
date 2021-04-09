import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/hotlines.dart';

abstract class HotlineState extends Equatable{
  const HotlineState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HotlinesInitial extends HotlineState {}

class HotlinesLoading extends HotlineState {}

class HotlinesError extends HotlineState {}

class HotlinesEmpty extends HotlineState {}

class HotlinesLoaded extends HotlineState {
  final Hotlines hotlines;
  @override
  List<Hotlines> get props => [hotlines];

  HotlinesLoaded(this.hotlines) : assert(hotlines != null);
}
