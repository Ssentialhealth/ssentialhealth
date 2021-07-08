import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CongenitalConditionDetailsEvent extends Equatable {
  const CongenitalConditionDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchCongenitalConditionDetails extends CongenitalConditionDetailsEvent {
  final int id;
  const FetchCongenitalConditionDetails({@required this.id});
}