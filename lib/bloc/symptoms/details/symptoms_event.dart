import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SymptomDetailsEvent extends Equatable {
  const SymptomDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchSymptomDetails extends SymptomDetailsEvent {
  final int id;
  const FetchSymptomDetails({@required this.id});
}