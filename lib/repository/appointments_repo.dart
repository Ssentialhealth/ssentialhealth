import 'dart:async';

import 'package:pocket_health/models/appoinment_model.dart';
import 'package:pocket_health/services/api_service.dart';

class AppointmentsRepo {
  final ApiService apiService;

  AppointmentsRepo(this.apiService);

  Future<AppointmentModel> addAppointment(AppointmentModel appointment) async {
    return await apiService.bookAppointments(appointment);
  }
}
