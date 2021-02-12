import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/profile.dart';

abstract class UserProfileState extends Equatable{
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final Profile profile;
  @override
  List<Profile> get props => [profile];

  UserProfileLoaded(this.profile) : assert(profile != null);
}

class UserProfileError extends UserProfileState {}