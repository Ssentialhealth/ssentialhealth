import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PractitionerProfileEvent extends Equatable{
  const PractitionerProfileEvent();

  @override
  List<Object> get props => [];
}

class CreatePractitionerProfile extends PractitionerProfileEvent {

  final String surname;
  final String location;
  final String region;
  final String phone;
  final String healthInstitution;
  final String careType;
  final String practitioner;
  final String speciality;
  final String affiliatedInstitution;
  final String operationTime;
  final String onlineBooking;
  final String onlinePrice;
  final String inPerson;
  final String personalPrice;
  final String followUp;
  final String followPrice;


  CreatePractitionerProfile({
    @required this.surname,
    @required this.onlinePrice,
    @required this.personalPrice,
    @required this.followPrice,
    @required this.location,
    @required this.region,
    @required this.phone,
    @required this.healthInstitution,
    @required this.careType,
    @required this.practitioner,
    @required this.speciality,
    @required this.affiliatedInstitution,
    @required this.operationTime,
    @required this.onlineBooking,
    @required this.inPerson,
    @required this.followUp,

  });


}