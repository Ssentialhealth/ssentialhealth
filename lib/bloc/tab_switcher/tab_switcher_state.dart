part of 'tab_switcher_cubit.dart';

@immutable
abstract class TabSwitcherState {}

class TabSwitcherInitial extends TabSwitcherState {}

class AcceptedTabLoaded extends TabSwitcherState {}

class PendingTabLoaded extends TabSwitcherState {}

class DeclinedTabLoaded extends TabSwitcherState {}
