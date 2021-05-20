import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchOrganEvent extends Equatable{
  const SearchOrganEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchOrgan extends SearchOrganEvent {
  final String organ;
  const FetchSearchOrgan({@required this.organ});
}
