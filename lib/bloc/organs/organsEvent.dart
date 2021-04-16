import 'package:equatable/equatable.dart';

abstract class OrgansEvent extends Equatable{
  const OrgansEvent();

  @override
  List<Object> get props => [];

}

class FetchOrgans extends OrgansEvent {
  const FetchOrgans();
}