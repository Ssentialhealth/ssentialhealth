import 'package:equatable/equatable.dart';

abstract class CongenitalConditionEvent extends Equatable{
  const CongenitalConditionEvent();

  @override
  List<Object> get props => [];

}

class FetchCongenitalConditions extends CongenitalConditionEvent {
  const FetchCongenitalConditions();
}