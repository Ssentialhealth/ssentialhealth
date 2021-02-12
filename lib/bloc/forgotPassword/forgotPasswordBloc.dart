import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/models/ForgotPassword.dart';
import 'package:pocket_health/repository/forgotPasswordRepo.dart';
import 'forgortPasswordEvent.dart';
import 'forgotPasswordState.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent,ForgotPasswordState> {
    final ForgotPasswordRepo forgotPasswordRepo;
    ForgotPasswordBloc({@required this.forgotPasswordRepo}) : super(ForgotPasswordInitial());

    @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async*{
    if(event is GetResetEmail){
      yield ForgotPasswordLoading();
      try{
        final ForgotPassword forgotPassword = await forgotPasswordRepo.resetUserPassword(event.email);
        if(forgotPassword != null) {
          yield ForgotPasswordLoading();
        }else {
          yield ForgotPasswordError();
        }
      }catch(e) {
        yield ForgotPasswordError();
      }
    }
  }
}