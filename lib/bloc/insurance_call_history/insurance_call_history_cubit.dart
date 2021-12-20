import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/insurance_call_history_model.dart';
import 'package:pocket_health/repository/insurance_call_history_repo.dart';

part 'insurance_call_history_state.dart';

class InsuranceCallHistoryCubit extends Cubit<InsuranceCallHistoryState> {
  final InsuranceCallHistoryRepo insuranceCallHistoryRepo;

  InsuranceCallHistoryCubit(this.insuranceCallHistoryRepo) : super(InsuranceCallHistoryInitial());

  void addCallHistory(int userID, int insuranceID, String startedAt, String endedAt) async {
    try {
      emit(InsuranceCallHistoryLoading());
      final Map<String, dynamic> mapData = {
        "startTime": startedAt,
        "endTime": endedAt,
        "duration": null,
        "user": userID,
        "profile": 16, //testing
      };

      final addedCall = await insuranceCallHistoryRepo.registerInsuranceCallHistory(mapData);

      emit(InsuranceCallHistorySuccess(addedCall));
    } catch (_) {
      emit(InsuranceCallHistoryFailure());
      print("add to call history failed | $_");
    }
  }
}
