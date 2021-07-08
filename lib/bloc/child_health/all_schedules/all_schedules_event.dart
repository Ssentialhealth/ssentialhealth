import 'package:equatable/equatable.dart';

abstract class AllSchedulesEvent extends Equatable{
  const AllSchedulesEvent();

  @override
  List<Object> get props => [];

}

class FetchAllSchedules extends AllSchedulesEvent {
  const FetchAllSchedules();
}