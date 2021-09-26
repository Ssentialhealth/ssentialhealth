import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/models/accept_decline_model.dart';

import 'acccept_decline_repo.dart';

part 'accept_decline_state.dart';

class AcceptDeclineCubit extends Cubit<AcceptDeclineState> {
  final AcceptDeclineRepo accceptDeclineRepo;

  AcceptDeclineCubit(this.accceptDeclineRepo) : super(AcceptDeclineInitial());

  void accept({int patientID, String phoneNumber, bool waitingStatus}) async {
    final mapData = AcceptDeclineModel(
      phoneNumber: phoneNumber,
      waitingStatus: waitingStatus,
      user: patientID,
    );
    try {
      emit(AcceptDeclineLoading());
      final booking = await accceptDeclineRepo.acceptPatient(mapData);
      emit(AcceptDeclineSuccess(booking));
    } catch (_) {
      emit(AcceptDeclineFailure());

      print("accepting failed | $_");
    }
  }

  void decline({int patientID, String phoneNumber, bool waitingStatus}) async {
    try {
      final mapData = AcceptDeclineModel(
        phoneNumber: phoneNumber,
        waitingStatus: waitingStatus,
        user: patientID,
      );
      emit(AcceptDeclineLoading());
      final booking = await accceptDeclineRepo.acceptPatient(mapData);
      emit(AcceptDeclineSuccess(booking));
    } catch (_) {
      emit(AcceptDeclineFailure());

      print("accepting failed | $_");
    }
  }
}
