import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/emergency_contact.dart';

abstract class EmergencyContactState extends Equatable{
  const EmergencyContactState();

  @override
  List<Object> get props => [];
}

class EmergencyContactInitial extends EmergencyContactState {}

class EmergencyContactLoading extends EmergencyContactState {}

class EmergencyContactLoaded extends EmergencyContactState {
  final EmergencyContact emergencyContact;
  @override
  List<EmergencyContact> get props => [emergencyContact];

  EmergencyContactLoaded(this.emergencyContact) : assert(emergencyContact != null);
}

class EmergencyContactError extends EmergencyContactState {}