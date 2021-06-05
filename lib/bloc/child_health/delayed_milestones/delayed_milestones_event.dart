import 'package:equatable/equatable.dart';

abstract class DelayedMilestoneEvent extends Equatable{
  const DelayedMilestoneEvent();

  @override
  List<Object> get props => [];

}

class FetchDelayedMilestones extends DelayedMilestoneEvent {
  const FetchDelayedMilestones();
}