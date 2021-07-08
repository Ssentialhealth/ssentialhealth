import 'package:equatable/equatable.dart';

abstract class ChildConditionEvent extends Equatable{
  const ChildConditionEvent();

  @override
  List<Object> get props => [];

}

class FetchChildConditions extends ChildConditionEvent {
  const FetchChildConditions();
}