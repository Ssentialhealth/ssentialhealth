import 'package:equatable/equatable.dart';

abstract class AdultUnwellEvent extends Equatable{
  const AdultUnwellEvent();

  @override
  List<Object> get props => [];

}

class FetchConditions extends AdultUnwellEvent {
  const FetchConditions();
}