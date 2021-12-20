import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_insurance_contacts_state.dart';

class SavedInsuranceContactsCubit extends Cubit<SavedInsuranceContactsState> {
  SavedInsuranceContactsCubit() : super(SavedInsuranceContactsInitial());

  void addRemoveContacts(isSaved, insuranceID) async {
    if (isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("savedinsurances") ?? prefs.setStringList("savedinsurances", []);
        await prefs.setStringList("savedinsurances", prefs.getStringList("savedinsurances")..add("$insuranceID"));
        emit(SavedInsuranceContactsSuccess(prefs.getStringList("savedinsurances")));
      } catch (_) {
        emit(SavedInsuranceContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
    if (!isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("savedinsurances") ?? prefs.setStringList("savedinsurances", []);
        await prefs.setStringList("savedinsurances", prefs.getStringList("savedinsurances")..remove("$insuranceID"));
        emit(SavedInsuranceContactsSuccess(prefs.getStringList("savedinsurances")));
      } catch (_) {
        emit(SavedInsuranceContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
  }

  void fetchContacts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SavedInsuranceContactsSuccess(prefs.getStringList("savedinsurances") ?? []));
    } catch (_) {
      emit(SavedInsuranceContactsFailure());
      print('--------|failed to save|--------|value -> ${_.toString()}');
      print("fetchContacts failed | $_");
    }
  }
}
