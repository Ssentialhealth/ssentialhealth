import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/repository/call_history_repo.dart';

part 'call_history_state.dart';

class CallHistoryCubit extends Cubit<CallHistoryState> {
  final CallHistoryRepo callHistoryRepo;

  CallHistoryCubit(this.callHistoryRepo) : super(CallHistoryInitial());

  void addCallHistory(int userID, int docID, String startedAt, String endedAt) async {
    try {
      emit(CallHistoryLoading());
      final callHistoryModel = CallHistoryModel(
        user: userID,
        endedAt: endedAt,
        startedAt: startedAt,
      );

      final addedCall = await callHistoryRepo.registerCallHistory(callHistoryModel);

      emit(CallHistorySuccess(addedCall));
    } catch (_) {
      emit(CallHistoryFailure());
      print("add to call history failed | $_");
    }
  }
}
