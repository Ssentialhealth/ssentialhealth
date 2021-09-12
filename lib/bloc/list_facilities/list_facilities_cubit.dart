import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/repository/facility_profile_repo.dart';

part 'list_facilities_state.dart';

class ListFacilitiesCubit extends Cubit<ListFacilitiesState> {
  final FacilityProfileRepo facilityProfileRepo;

  ListFacilitiesCubit({this.facilityProfileRepo}) : super(ListFacilitiesInitial());

  Future listFacilities(filterByFacilityType) async {
    try {
      emit(ListFacilitiesLoading());
      final List<FacilityProfileModel> facilityProfiles = await facilityProfileRepo.getFacilities(filterByFacilityType);
      print('facilities length -- ${facilityProfiles.length}');
      emit(ListFacilitiesSuccess(facilityProfiles));
    } catch (_) {
      emit(ListFacilitiesFailure());
      print("facilities listing failed | $_");
    }
  }

  Future filterFacilities({
    @required String filterByDistance,
    @required String facilityCategory,
    @required String filterByPrice,
    @required String filterByAvailability,
    @required String sortByNearest,
    @required String sortByCheapest,
    @required String sortByHighestRated,
    @required String filterBySpeciality,
    @required String filterFacilitiesByCountry,
  }) async {
    try {
      emit(ListFacilitiesLoading());
      final List<FacilityProfileModel> filteredPractitionerProfiles = await facilityProfileRepo.filterFacilities(
        filterByDistance: filterByDistance,
        filterByPrice: filterByPrice,
        filterByAvailability: filterByAvailability,
        filterBySpeciality: filterBySpeciality,
        sortByCheapest: sortByCheapest,
        sortByNearest: sortByNearest,
        sortByHighestRated: sortByHighestRated,
        facilityCategory: facilityCategory,
        filterFacilitiesByCountry: filterFacilitiesByCountry,
      );
      emit(ListFacilitiesSuccess(filteredPractitionerProfiles));
    } catch (_) {
      emit(ListFacilitiesFailure());
      print("filter facilities failure | $_");
    }
  }
}
