import 'package:equatable/equatable.dart';

abstract class NormalDevelopmentEvent extends Equatable{
  const NormalDevelopmentEvent();

  @override
  List<Object> get props => [];

}

class FetchNormalDevelopment extends NormalDevelopmentEvent {
  const FetchNormalDevelopment();
}