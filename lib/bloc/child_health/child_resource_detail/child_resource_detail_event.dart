import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ChildResourceDetailsEvent extends Equatable {
  const ChildResourceDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchChildResourceDetails extends ChildResourceDetailsEvent {
  final int id;
  const FetchChildResourceDetails({@required this.id});
}