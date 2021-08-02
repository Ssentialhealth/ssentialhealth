import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/profile/userProfileEvent.dart';
import 'package:pocket_health/bloc/profile/userProfileState.dart';
import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/repository/userProfile_repo.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepo userProfileRepo;
  UserProfileBloc({@required this.userProfileRepo}) : super(UserProfileInitial());

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
          event.photo,
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

			  yield UserProfileLoaded(profile);
      } catch (e) {
			  yield UserProfileError(e.toString());
        print("Name:" + e.toString());
      }
    }
  }
}
