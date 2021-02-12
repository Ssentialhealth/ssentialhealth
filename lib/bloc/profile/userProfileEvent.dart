import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable{
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateUserProfile extends UserProfileEvent {
  const CreateUserProfile();
}

