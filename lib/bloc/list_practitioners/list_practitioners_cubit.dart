import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/repository/practitionerProfileRepo.dart';

part 'list_practitioners_state.dart';

class ListPractitionersCubit extends Cubit<ListPractitionersState> {
  final PractitionerProfileRepo practitionerProfileRepo;

  ListPractitionersCubit({@required this.practitionerProfileRepo}) : super(ListPractitionersInitial());

  Future listPractitioners() async {
    try {
      emit(ListPractitionersLoading());
      final List<PractitionerProfileModel> practitionerProfiles = await practitionerProfileRepo.getPractitioners();
      print('practitioner length -- ${practitionerProfiles.length}');
      emit(ListPractitionersLoaded(practitionerProfiles));
    } catch (_) {
      emit(ListPractitionersFailure());
      print("practitioner listing failed | $_");
    }
  }

  Future filterPractitioners({
    @required String filterByDistance,
    @required String practitionersCategory,
    @required String filterByPrice,
    @required String filterByAvailability,
    @required String sortByNearest,
    @required String sortByCheapest,
    @required String sortByHighestRated,
    @required String filterBySpeciality,
  }) async {
    try {
      emit(ListPractitionersLoading());
      final List<PractitionerProfileModel> filteredPractitionerProfiles = await practitionerProfileRepo.filterPractitioners(
          filterByDistance: filterByDistance,
          filterByPrice: filterByPrice,
          filterByAvailability: filterByAvailability,
          filterBySpeciality: filterBySpeciality,
          sortByCheapest: sortByCheapest,
          sortByNearest: sortByNearest,
          sortByHighestRated: sortByHighestRated,
          practitionersCategory: practitionersCategory);
      emit(ListPractitionersLoaded(filteredPractitionerProfiles));
    } catch (_) {
      emit(ListPractitionersFailure());
      print("filter practitioners failure | $_");
    }
  }
}
