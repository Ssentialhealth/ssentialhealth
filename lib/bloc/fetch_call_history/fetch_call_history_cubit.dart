import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
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
      final allCallHistory = await fetchCallHistoryRepo.getCallHistoryByuserID(userID);
      print(allCallHistory.toString());
      int totalTalkTime = 0;
      List<PractitionerProfileModel> allDocDetails = [];
      if (allCallHistory.length == 0) {
        emit(FetchCallHistorySuccess(allCallHistory, 0, allDocDetails));
      } else
        allCallHistory?.forEach((element) async {
          // final docDetails = [ ];
          // = await fetchCallHistoryRepo.getDocDetails(element?.profile);
          // allDocDetails.add(docDetails);
          final talkTime = DateFormat.Hms().parse(element.endedAt).second - DateFormat.Hms().parse(element.startedAt).second;
          totalTalkTime += talkTime;
          print(talkTime);
          return emit(FetchCallHistorySuccess(allCallHistory, totalTalkTime, allDocDetails));
        });
    } catch (_) {
      emit(FetchCallHistoryFailure());
      print("get call history failed | $_");
    }
  }
}
