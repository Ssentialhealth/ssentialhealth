import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactEvent.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactState.dart';
import 'package:pocket_health/models/emergency_contact.dart';
import 'package:pocket_health/repository/emergencyContactRepo.dart';

class EmergencyContactBloc extends Bloc<EmergencyContactEvent,EmergencyContactState>{
  final EmergencyContactRepo emergencyContactRepo;
  EmergencyContactBloc({@required this.emergencyContactRepo}) : super(EmergencyContactInitial());

  EmergencyContactState get initialState => EmergencyContactInitial();

  @override
  Stream<EmergencyContactState> mapEventToState(
      EmergencyContactEvent event
      )async* {
    if(event is AddContacts){
      yield EmergencyContactLoading();
      try{
        final EmergencyContact emergencyContact = await emergencyContactRepo.addContacts(
            event.ambulanceName,
            event.countryCode,
            event.ambulancePhone,
            event.insurerName,
            event.insuaranceNumber,
            event.insuarerNumber,
            event.emergenceName,
            event.emergencyRelation,
            event.emergencyNumber
        );
        if(emergencyContact != null) {
          yield EmergencyContactLoaded(emergencyContact);
        }
      }catch(e) {
        yield EmergencyContactError();
      }
    }
  }
}