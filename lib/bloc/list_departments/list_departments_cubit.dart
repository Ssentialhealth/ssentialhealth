import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocket_health/services/api_service.dart';

part 'list_departments_state.dart';

class ListDepartmentsCubit extends Cubit<ListDepartmentsState> {
  final DepartmentsRepo departmentsRepo;

  ListDepartmentsCubit(this.departmentsRepo) : super(ListDepartmentsInitial());

  void loadDepartmentsByFacilityID(facilityID) async {
    try {
      emit(ListDepartmentsInitial());

      final departments = await departmentsRepo.getDeparmentsByFacilityID(facilityID);
    } catch (_) {
      print("load departments failed | $_");
    }
  }
}

class DepartmentsRepo {
  final ApiService apiService;

  DepartmentsRepo(this.apiService);

  Future getDeparmentsByFacilityID(facilityID) async {
    return apiService.fetchDepartmentsByFacilityID(facilityID);
  }
}
