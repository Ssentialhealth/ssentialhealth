import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/repository/fetch_facility_call_history_repo.dart';

part 'fetch_facility_call_history_state.dart';

class FetchFacilityCallHistoryCubit extends Cubit<FetchFacilityCallHistoryState> {
  final FetchFacilityCallHistoryRepo fetchFacilityCallHistoryRepo;

  FetchFacilityCallHistoryCubit(this.fetchFacilityCallHistoryRepo) : super(FetchFacilityCallHistoryInitial());

  void getCallHistory(int userID) async {
    try {
      emit(FetchFacilityCallHistoryLoading());
      final allFacilitiesCalled = await fetchFacilityCallHistoryRepo.getCallHistoryFacilityDetails(userID);
      final allFacilityCallHistory = await fetchFacilityCallHistoryRepo.getAllCallHistory(allFacilitiesCalled, userID);

      emit(FetchFacilityCallHistorySuccess(allFacilitiesCalled, allFacilityCallHistory));
    } catch (_) {
      emit(FetchFacilityCallHistoryFailure());
      print("get call history failed | $_");
    }
  }
}
