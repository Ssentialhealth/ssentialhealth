part of 'saved_insurance_contacts_cubit.dart';

abstract class SavedInsuranceContactsState extends Equatable {
  const SavedInsuranceContactsState();
}

class SavedInsuranceContactsInitial extends SavedInsuranceContactsState {
  @override
  List<Object> get props => [];
}

class SavedInsuranceContactsSuccess extends SavedInsuranceContactsState {
  final List<String> savedInsuranceContacts;

  SavedInsuranceContactsSuccess(this.savedInsuranceContacts);

  @override
  List<Object> get props => [savedInsuranceContacts];
}

class SavedInsuranceContactsLoading extends SavedInsuranceContactsState {
  SavedInsuranceContactsLoading();

  @override
  List<Object> get props => [];
}

class SavedInsuranceContactsFailure extends SavedInsuranceContactsState {
  @override
  List<Object> get props => [];
}
