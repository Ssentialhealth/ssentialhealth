import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserProfileEvent extends Equatable{
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateUserProfile extends UserProfileEvent {
  final String surname;
  final String phone;
  final String dob;
  final String gender;
  final String residence;
  final String country;
  final String blood;
  final String chronic;
  final String longTerm;
  final String date;
  final String condition;
  final String code;
  final String dissabilities;
  final String recreational;
  final String drugAllergies;
  final String foodAllergies;
  CreateUserProfile({
    @required this.surname,
    @required this.phone,
    @required this.dob,
    @required this.gender,
    @required this.residence,
    @required this.country,
    @required this.blood,
    @required this.chronic,
    @required this.longTerm,
    @required this.date,
    @required this.condition,
    @required this.code,
    @required this.dissabilities,
    @required this.recreational,
    @required this.drugAllergies,
    @required this.foodAllergies,
  });

}



