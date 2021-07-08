import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ChildConditionDetailsEvent extends Equatable {
  const ChildConditionDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchChildConditionDetails extends ChildConditionDetailsEvent {
  final int id;
  const FetchChildConditionDetails({@required this.id});
}