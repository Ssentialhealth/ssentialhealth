import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
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
        profile: docID,
      );

      final addedCall = await callHistoryRepo.registerCallHistory(callHistoryModel);
      final allCallHistory = await callHistoryRepo.getAllCallHistory(userID);
      int totalTalkTime = 0;

      allCallHistory.forEach((element) {
        final talkTime = DateFormat.Hms().parse(element.endedAt).second - DateFormat.Hms().parse(element.startedAt).second;
        totalTalkTime += talkTime;
        print(talkTime);
      });

      emit(CallHistorySuccess(addedCall, allCallHistory, totalTalkTime));
    } catch (_) {
      emit(CallHistoryFailure());
      print("add to call history failed | $_");
    }
  }
}
