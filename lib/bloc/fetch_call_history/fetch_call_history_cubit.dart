import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/repository/fetch_call_history_repo.dart';

part 'fetch_call_history_state.dart';

class FetchCallHistoryCubit extends Cubit<FetchCallHistoryState> {
  final FetchCallHistoryRepo fetchCallHistoryRepo;

  FetchCallHistoryCubit(this.fetchCallHistoryRepo) : super(FetchCallHistoryInitial());

  void getCallHistory(int userID) async {
    try {
      emit(FetchCallHistoryLoading());
      final allDoctorsCalled = await fetchCallHistoryRepo.getCallHistoryByuserID(userID);
      emit(FetchCallHistorySuccess(allDoctorsCalled));
      // print('--------|alldocscalled|--------|value -> ${allDoctorsCalled[0].user.toString()}');
    } catch (_) {
      emit(FetchCallHistoryFailure());
      print("get call history failed | $_");
    }
  }
}
