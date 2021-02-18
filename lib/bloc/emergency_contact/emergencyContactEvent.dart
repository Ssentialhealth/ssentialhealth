import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class EmergencyContactEvent extends Equatable {
  const EmergencyContactEvent();

  @override
  List<Object> get props => [];
}

class AddContacts extends EmergencyContactEvent{
  final String ambulanceName;
  final String countryCode;
  final String ambulancePhone;
  final String insurerName;
  final String insuaranceNumber;
  final String insuarerNumber;
  final String emergenceName;
  final String emergencyRelation;
  final String emergencyNumber;

  AddContacts({
    @required this.ambulanceName,
    @required this.countryCode,
    @required this.ambulancePhone,
    @required this.insurerName,
    @required this.insuaranceNumber,
    @required this.insuarerNumber,
    @required this.emergenceName,
    @required this.emergencyRelation,
    @required this.emergencyNumber,
  });
}