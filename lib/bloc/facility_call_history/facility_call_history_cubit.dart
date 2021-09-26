import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/repository/facility_call_history_repo.dart';

part 'facility_call_history_state.dart';

class FacilityCallHistoryCubit extends Cubit<FacilityCallHistoryState> {
  final FacilityCallHistoryRepo facilityCallHistoryRepo;

  FacilityCallHistoryCubit(this.facilityCallHistoryRepo) : super(FacilityCallHistoryInitial());

  void addCallHistory(int userID, int facilityID, String startedAt, String endedAt) async {
    try {
      emit(FacilityCallHistoryLoading());
      final Map<String, dynamic> mapData = {
        "startTime": startedAt,
        "endTime": endedAt,
        "duration": null,
        "user": userID,
        "facility": facilityID,
      };

      final addedCall = await facilityCallHistoryRepo.registerFacilityCallHistory(mapData);

      emit(FacilityCallHistorySuccess(addedCall));
    } catch (_) {
      emit(FacilityCallHistoryFailure());
      print("add to call history failed | $_");
    }
  }
}
