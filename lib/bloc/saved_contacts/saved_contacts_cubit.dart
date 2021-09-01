import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_contacts_state.dart';

class SavedContactsCubit extends Cubit<SavedContactsState> {
  SavedContactsCubit() : super(SavedContactsInitial());

  void addRemoveContacts(isSaved, docID) async {
    if (isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("saveddocs") ?? prefs.setStringList('saveddocs', []);
        await prefs.setStringList('saveddocs', prefs.getStringList("saveddocs")..add("$docID"));
        emit(SavedContactsSuccess(prefs.getStringList("saveddocs")));
      } catch (_) {
        emit(SavedContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
    if (!isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("saveddocs") ?? prefs.setStringList('saveddocs', []);
        await prefs.setStringList('saveddocs', prefs.getStringList("saveddocs")..remove("$docID"));
        emit(SavedContactsSuccess(prefs.getStringList("saveddocs")));
      } catch (_) {
        emit(SavedContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
  }

  void fetchContacts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SavedContactsSuccess(prefs.getStringList("saveddocs") ?? []));
    } catch (_) {
      emit(SavedContactsFailure());
      print('--------|failed to save|--------|value -> ${_.toString()}');
      print("fetchContacts failed | $_");
    }
  }
}
