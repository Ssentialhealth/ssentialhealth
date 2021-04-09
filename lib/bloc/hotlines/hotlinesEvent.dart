import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HotlinesEvent extends Equatable{
  const HotlinesEvent();

  @override
  List<Object> get props => [];
}

class FetchHotline extends HotlinesEvent {
  final String country;
  const FetchHotline({@required this.country});
}
