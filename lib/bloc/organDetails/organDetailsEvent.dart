import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class OrganDetailsEvent extends Equatable {
  const OrganDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchOrganDetails extends OrganDetailsEvent {
  final int id;
  const FetchOrganDetails({@required this.id});
}