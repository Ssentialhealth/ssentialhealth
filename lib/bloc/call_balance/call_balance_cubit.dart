import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_health/models/call_balance_model.dart';
import 'package:pocket_health/repository/call_balance_repo.dart';

part 'call_balance_state.dart';

class CallBalanceCubit extends Cubit<CallBalanceState> {
  final CallBalanceRepo callBalanceRepo;

  CallBalanceCubit(this.callBalanceRepo) : super(CallBalanceInitial());

  void getCallBalance(userID) async {
    try {
      emit(CallBalanceLoading());
      final callBalanceModel = await callBalanceRepo.getCallBalance(userID);
      emit(CallBalanceFetchSuccess(callBalanceModel));
    } catch (_) {
      emit(CallBalanceFailure());
      print("get call balance failed | $_");
    }
  }

  void creditDeductAdd({
    @required String paymentType,
    @required int balance,
    @required int amount,
    @required String currency,
    @required int user,
  }) async {
    try {
      emit(CallBalanceLoading());
      Map<String, dynamic> paymentData = ({
        "payment_type": paymentType,
        "amount": amount,
        "balance": balance,
        "currency": currency,
        "user": user,
      });

      final payment = await callBalanceRepo.initPaymentForCall(paymentData);

      emit(CallBalanceAddSuccess(payment));
    } catch (_) {
      emit(CallBalanceFailure());
      print("pay for call | $_");
    }
  }
}
