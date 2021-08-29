import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/repository/fetch_call_history_repo.dart';

part 'fetch_call_history_state.dart';

class FetchCallHistoryCubit extends Cubit<FetchCallHistoryState> {
  final FetchCallHistoryRepo fetchCallHistoryRepo;

  FetchCallHistoryCubit(this.fetchCallHistoryRepo) : super(FetchCallHistoryInitial());

  void getCallHistory(int userID) async {
    try {
      emit(FetchCallHistoryLoading());
      final allDoctorsCalled = await fetchCallHistoryRepo.getCallHistoryDocDetails(userID);
      final allCallHistory = await fetchCallHistoryRepo.getAllCallHistory(allDoctorsCalled, userID);

      emit(FetchCallHistorySuccess(allDoctorsCalled, allCallHistory));
    } catch (_) {
      emit(FetchCallHistoryFailure());
      print("get call history failed | $_");
    }
  }
}
