part of 'list_practitioners_cubit.dart';

abstract class ListPractitionersState extends Equatable {
  const ListPractitionersState();
}

class ListPractitionersInitial extends ListPractitionersState {
  @override
  List<Object> get props => [];
}

class ListPractitionersLoading extends ListPractitionersState {
  @override
  List<Object> get props => [];
}

class ListPractitionersFailure extends ListPractitionersState {
  @override
  List<Object> get props => [];
}

class ListPractitionersLoaded extends ListPractitionersState {
  final List<PractitionerProfileModel> practitionerProfiles;

  ListPractitionersLoaded(this.practitionerProfiles) : assert(practitionerProfiles != null);

  @override
  List<PractitionerProfileModel> get props => practitionerProfiles;
}

class FilterPractitionersLoading extends ListPractitionersState {
  @override
  List<Object> get props => [];
}

class FilterPractitionersFailure extends ListPractitionersState {
  @override
  List<Object> get props => [];
}

class FilterPractitionersLoaded extends ListPractitionersState {
  final List<PractitionerProfileModel> filteredPractitionerProfiles;

  FilterPractitionersLoaded(this.filteredPractitionerProfiles) : assert(filteredPractitionerProfiles != null);

  @override
  List<PractitionerProfileModel> get props => filteredPractitionerProfiles;
}
