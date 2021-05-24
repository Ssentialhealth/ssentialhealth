import 'package:equatable/equatable.dart';

abstract class ChildResourceEvent extends Equatable{
  const ChildResourceEvent();

  @override
  List<Object> get props => [];

}

class FetchResource extends ChildResourceEvent {
  const FetchResource();
}