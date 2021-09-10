part of 'list_facilities_cubit.dart';

abstract class ListFacilitiesState extends Equatable {
  const ListFacilitiesState();
}

class ListFacilitiesInitial extends ListFacilitiesState {
  @override
  List<Object> get props => [];
}

class ListFacilitiesLoading extends ListFacilitiesState {
  @override
  List<Object> get props => [];
}

class ListFacilitiesSuccess extends ListFacilitiesState {
  final List<FacilityProfileModel> facilityProfiles;

  ListFacilitiesSuccess(this.facilityProfiles);

  @override
  List<Object> get props => [facilityProfiles];
}

class ListFacilitiesFailure extends ListFacilitiesState {
  @override
  List<Object> get props => [];
}
