import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/profile/userProfileEvent.dart';
import 'package:pocket_health/bloc/profile/userProfileState.dart';

import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/repository/userProfile_repo.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepo userProfileRepo;
  UserProfileBloc({@required this.userProfileRepo}) : super(UserProfileInitial()){
    add(CreateUserProfile());
  }

  UserProfileState get initialState => UserProfileInitial();


  @override
  Stream<UserProfileState> mapEventToState(
      UserProfileEvent event,
      ) async* {
    if (event is CreateUserProfile) {
      yield UserProfileLoading();
      try {
        final Profile profile = await userProfileRepo.createUserProfile();
        if (profile != null) {
          yield UserProfileLoaded(profile);
        } else {
          yield UserProfileError();
        }
      } catch (e) {
        yield UserProfileError();
      }
    }
  }


}