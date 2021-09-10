import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/repository/facility_profile_repo.dart';

part 'list_facilities_state.dart';

class ListFacilitiesCubit extends Cubit<ListFacilitiesState> {
  final FacilityProfileRepo facilityProfileRepo;

  ListFacilitiesCubit({this.facilityProfileRepo}) : super(ListFacilitiesInitial());

  Future listFacilities() async {
    try {
      emit(ListFacilitiesLoading());
      final List<FacilityProfileModel> facilityProfiles = await facilityProfileRepo.getFacilities();
      print('facilities length -- ${facilityProfiles.length}');
      emit(ListFacilitiesSuccess(facilityProfiles));
    } catch (_) {
      emit(ListFacilitiesFailure());
      print("facilities listing failed | $_");
    }
  }
}
