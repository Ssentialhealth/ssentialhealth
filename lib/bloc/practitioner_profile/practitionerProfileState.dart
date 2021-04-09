import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/PractitionerProfile.dart';

abstract class PractitionerProfileState extends Equatable{
  const PractitionerProfileState();

  @override
  List<Object> get props => [];
}

class  PractitionerProfileInitial extends PractitionerProfileState {}

class PractitionerProfileLoading extends PractitionerProfileState {}

class PractitionerProfileLoaded extends PractitionerProfileState {
  final PractitionerProfile practitionerProfile;
  @override
  List<PractitionerProfile> get props => [practitionerProfile];

  PractitionerProfileLoaded(this.practitionerProfile): assert(practitionerProfile != null);
}

class PractitionerProfileError extends PractitionerProfileState {
  final String errorMessage;
  PractitionerProfileError(this.errorMessage);
}