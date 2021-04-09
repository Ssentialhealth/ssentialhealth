import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ConditionDetailsEvent extends Equatable {
  const ConditionDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchDetails extends ConditionDetailsEvent {
  final int id;
  const FetchDetails({@required this.id});
}