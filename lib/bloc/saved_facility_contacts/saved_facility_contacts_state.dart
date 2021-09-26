part of 'saved_facility_contacts_cubit.dart';

abstract class SavedFacilityContactsState extends Equatable {
  const SavedFacilityContactsState();
}

class SavedFacilityContactsInitial extends SavedFacilityContactsState {
  @override
  List<Object> get props => [];
}

class SavedFacilityContactsSuccess extends SavedFacilityContactsState {
  final List<String> savedFacilityContacts;

  SavedFacilityContactsSuccess(this.savedFacilityContacts);

  @override
  List<Object> get props => [savedFacilityContacts];
}

class SavedFacilityContactsLoading extends SavedFacilityContactsState {
  SavedFacilityContactsLoading();

  @override
  List<Object> get props => [];
}

class SavedFacilityContactsFailure extends SavedFacilityContactsState {
  @override
  List<Object> get props => [];
}
