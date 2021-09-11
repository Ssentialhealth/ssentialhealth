import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_facility_contacts_state.dart';

class SavedFacilityContactsCubit extends Cubit<SavedFacilityContactsState> {
  SavedFacilityContactsCubit() : super(SavedFacilityContactsInitial());

  void addRemoveContacts(isSaved, facilityID) async {
    if (isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("savedfacilities") ?? prefs.setStringList("savedfacilities", []);
        await prefs.setStringList("savedfacilities", prefs.getStringList("savedfacilities")..add("$facilityID"));
        emit(SavedFacilityContactsSuccess(prefs.getStringList("savedfacilities")));
      } catch (_) {
        emit(SavedFacilityContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
    if (!isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("savedfacilities") ?? prefs.setStringList("savedfacilities", []);
        await prefs.setStringList("savedfacilities", prefs.getStringList("savedfacilities")..remove("$facilityID"));
        emit(SavedFacilityContactsSuccess(prefs.getStringList("savedfacilities")));
      } catch (_) {
        emit(SavedFacilityContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
  }

  void fetchContacts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SavedFacilityContactsSuccess(prefs.getStringList("savedfacilities") ?? []));
    } catch (_) {
      emit(SavedFacilityContactsFailure());
      print('--------|failed to save|--------|value -> ${_.toString()}');
      print("fetchContacts failed | $_");
    }
  }
}
