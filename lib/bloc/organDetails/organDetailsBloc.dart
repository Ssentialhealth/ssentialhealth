import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailState.dart';
import 'package:pocket_health/bloc/conditionDetails/conditionDetailsEvent.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsEvent.dart';
import 'package:pocket_health/bloc/organDetails/organDetailsState.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/organDetailsModel.dart';
import 'package:pocket_health/repository/conditionDetailRepo.dart';
import 'package:pocket_health/repository/organDetailsRepo.dart';

class OrgansDetailsBloc extends Bloc<OrganDetailsEvent,OrganDetailsState>{
  final OrganDetailsRepo organDetailsRepo;
  OrgansDetailsBloc({@required this.organDetailsRepo}) : super(OrganDetailsInitial());

  OrganDetailsState get initialState => OrganDetailsInitial();

  @override
  Stream<OrganDetailsState> mapEventToState(
      OrganDetailsEvent event)async*{
    if(event is FetchOrganDetails){
      yield OrganDetailsLoading();
      try{
        final OrganDetailsModel organDetailsModel = await organDetailsRepo.getOrganDetails(event.id);
        yield OrganDetailsLoaded(organDetailsModel);
      }catch(e){
        yield OrganDetailsError();
        print(e.toString());
      }
    }
  }
}