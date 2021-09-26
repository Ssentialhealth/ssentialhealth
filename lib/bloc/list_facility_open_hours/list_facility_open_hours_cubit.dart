import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/facility_open_hours_model.dart';
import 'package:pocket_health/repository/open_hours_repo.dart';

part 'list_facility_open_hours_state.dart';

class ListFacilityOpenHoursCubit extends Cubit<ListFacilityOpenHoursState> {
  final OpenHoursRepo openHoursRepo;

  ListFacilityOpenHoursCubit(this.openHoursRepo) : super(ListFacilityOpenHoursInitial());

  void listOpenHoursById(facilityID) async {
    try {
      emit(ListFacilityOpenHoursLoading());
      final List<FacilityOpenHoursModel> openHours = await openHoursRepo.getOpenHours(facilityID);
      emit(ListFacilityOpenHoursSuccess(openHours));
    } catch (_) {
      emit(ListFacilityOpenHoursFailure());
      print("list facilities failed | $_");
    }
  }
}
