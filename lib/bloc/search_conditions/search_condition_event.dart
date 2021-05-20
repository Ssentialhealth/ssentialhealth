import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchConditionEvent extends Equatable{
  const SearchConditionEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchCondition extends SearchConditionEvent {
  final String condition;
  const FetchSearchCondition({@required this.condition});
}
