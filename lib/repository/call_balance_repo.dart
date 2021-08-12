import 'package:pocket_health/models/call_balance_model.dart';
import 'package:pocket_health/services/api_service.dart';

class CallBalanceRepo {
  final ApiService apiService;

  CallBalanceRepo(this.apiService);

  Future<CallBalanceModel> getCallBalance() async {
    return await apiService.fetchCallBalance();
  }

  Future<CallBalanceModel> initPaymentForCall(paymentData) async {
    return await apiService.addCallPayment(paymentData);
  }
}
