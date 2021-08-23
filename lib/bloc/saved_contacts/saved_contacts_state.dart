part of 'saved_contacts_cubit.dart';

abstract class SavedContactsState extends Equatable {
  const SavedContactsState();
}

class SavedContactsInitial extends SavedContactsState {
  @override
  List<Object> get props => [];
}

class SavedContactsFailure extends SavedContactsState {
  @override
  List<Object> get props => [];
}

class SavedContactsSuccess extends SavedContactsState {
  final List<String> savedContacts;

  SavedContactsSuccess(this.savedContacts);

  @override
  List<Object> get props => [savedContacts];
}
