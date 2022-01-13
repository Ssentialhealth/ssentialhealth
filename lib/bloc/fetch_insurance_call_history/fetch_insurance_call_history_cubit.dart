import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/models/insurance_call_history_model.dart';
import 'package:pocket_health/repository/fetch_insurance_call_history_repo.dart';

part 'fetch_insurance_call_history_state.dart';

class FetchInsuranceCallHistoryCubit extends Cubit<FetchInsuranceCallHistoryState> {
  final FetchInsuranceCallHistoryRepo fetchInsuranceCallHistoryRepo;

  FetchInsuranceCallHistoryCubit(this.fetchInsuranceCallHistoryRepo) : super(FetchInsuranceCallHistoryInitial());

  void getCallHistory(int userID) async {
    try {
      emit(FetchInsuranceCallHistoryLoading());
      final allInsurancesCalled = await fetchInsuranceCallHistoryRepo.getCallHistoryInsuranceDetails(userID);
      final allInsuranceCallHistory = await fetchInsuranceCallHistoryRepo.getAllCallHistory(allInsurancesCalled, userID);

      emit(FetchInsuranceCallHistorySuccess(allInsurancesCalled, allInsuranceCallHistory));
    } catch (_) {
      emit(FetchInsuranceCallHistoryFailure());
      print("get call history failed | $_");
    }
  }
}
