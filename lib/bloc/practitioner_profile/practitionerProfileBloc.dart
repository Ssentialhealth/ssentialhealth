import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileEvent.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileState.dart';
import 'package:pocket_health/models/PractitionerProfile.dart';
import 'package:pocket_health/repository/practitionerProfileRepo.dart';

class PractitionerProfileBloc extends Bloc<PractitionerProfileEvent,PractitionerProfileState> {
  final PractitionerProfileRepo practitionerProfileRepo;
  PractitionerProfileBloc({@required this.practitionerProfileRepo}) : super(PractitionerProfileInitial());

  PractitionerProfileState get initialState => PractitionerProfileInitial();

  @override
  Stream<PractitionerProfileState> mapEventToState(
      PractitionerProfileEvent event,
      ) async*{
    if (event is CreatePractitionerProfile){
      yield PractitionerProfileLoading();
      try{
        final PractitionerProfile practitionerProfile = await practitionerProfileRepo.createPractitionerProfile(
            event.surname,
            event.location,
            event.region,
            event.phone,
            event.healthInstitution,
            event.careType,
            event.practitioner,
            event.speciality,
            event.affiliatedInstitution,
            event.operationTime,
            event.onlinePrice,
            event.onlinePriceB,
            event.onlinePriceC,
            event.personalPrice,
            event.personalBPrice,
            event.followPrice,
            event.followBPrice

        );
          yield PractitionerProfileLoaded(practitionerProfile);
      }catch (e) {
        yield PractitionerProfileError(e.toString());
      }
    }
  }

}