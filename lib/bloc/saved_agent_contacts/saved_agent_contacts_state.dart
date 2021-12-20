part of 'saved_agent_contacts_cubit.dart';

abstract class SavedAgentContactsState extends Equatable {
  const SavedAgentContactsState();
}

class SavedAgentContactsInitial extends SavedAgentContactsState {
  @override
  List<Object> get props => [];
}

class SavedAgentContactsSuccess extends SavedAgentContactsState {
  final List<String> savedAgentContacts;

  SavedAgentContactsSuccess(this.savedAgentContacts);

  @override
  List<Object> get props => [savedAgentContacts];
}

class SavedAgentContactsLoading extends SavedAgentContactsState {
  SavedAgentContactsLoading();

  @override
  List<Object> get props => [];
}

class SavedAgentContactsFailure extends SavedAgentContactsState {
  @override
  List<Object> get props => [];
}
