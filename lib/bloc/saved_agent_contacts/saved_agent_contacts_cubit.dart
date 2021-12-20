import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_agent_contacts_state.dart';

class SavedAgentContactsCubit extends Cubit<SavedAgentContactsState> {
  SavedAgentContactsCubit() : super(SavedAgentContactsInitial());

  void addRemoveContacts(isSaved, agentID) async {
    if (isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("savedagents") ?? prefs.setStringList("savedagents", []);
        await prefs.setStringList("savedagents", prefs.getStringList("savedagents")..add("$agentID"));
        emit(SavedAgentContactsSuccess(prefs.getStringList("savedagents")));
      } catch (_) {
        emit(SavedAgentContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
    if (!isSaved) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.getStringList("savedagents") ?? prefs.setStringList("savedagents", []);
        await prefs.setStringList("savedagents", prefs.getStringList("savedagents")..remove("$agentID"));
        emit(SavedAgentContactsSuccess(prefs.getStringList("savedagents")));
      } catch (_) {
        emit(SavedAgentContactsFailure());
        print('--------|failed to save|--------|value -> ${_.toString()}');
      }
    }
  }

  void fetchContacts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SavedAgentContactsSuccess(prefs.getStringList("savedagents") ?? []));
    } catch (_) {
      emit(SavedAgentContactsFailure());
      print('--------|failed to save|--------|value -> ${_.toString()}');
      print("fetchContacts failed | $_");
    }
  }
}
