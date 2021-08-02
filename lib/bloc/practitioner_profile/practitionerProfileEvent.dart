import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PractitionerProfileEvent extends Equatable {
  const PractitionerProfileEvent();

  @override
  List<Object> get props => [];
}

class CreatePractitionerProfile extends PractitionerProfileEvent {
  //General//
  final String surname;
  final String location;
  final String region;
  final String phone;
  //Health//
  final String healthInstitution;
  final String careType;
  final String practitioner;
  final String speciality;
  final String affiliatedInstitution;
  //Provider//
  final String operationTime;
  //online Booking//
  final String onlinePrice;
  final String onlinePriceB;
  final String onlinePriceC;
  //InPerson Booking//
  final String personalPrice;
  final String personalBPrice;
  //Follow Up//
  final String followPrice;
  final String followBPrice;

  CreatePractitionerProfile({
    @required this.surname,
    @required this.location,
    @required this.region,
    @required this.phone,
    @required this.healthInstitution,
    @required this.careType,
    @required this.practitioner,
    @required this.speciality,
    @required this.affiliatedInstitution,
    @required this.operationTime,
    @required this.onlinePrice,
    @required this.onlinePriceB,
    @required this.onlinePriceC,
    @required this.personalPrice,
    @required this.personalBPrice,
    @required this.followPrice,
    @required this.followBPrice,
  });
}
