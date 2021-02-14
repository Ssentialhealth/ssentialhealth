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
        final Profile profile = await userProfileRepo.createUserProfile(
          event.surname,
          event.phone,
          event.dob,
          event.gender,
          event.residence,
          event.country,
          event.blood,
          event.chronic,
          event.longTerm,
          event.date,
          event.condition,
          event.code,
          event.dissabilities,
          event.recreational,
          event.drugAllergies,
          event.foodAllergies,
        );
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