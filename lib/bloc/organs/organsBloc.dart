import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/organs/organsEvent.dart';
import 'package:pocket_health/bloc/organs/organsState.dart';
import 'package:pocket_health/models/organsModel.dart';
import 'package:pocket_health/repository/organsRepo.dart';



class OrgansBloc extends Bloc<OrgansEvent,OrgansState>{
  final OrgansRepo organsRepo;
  OrgansBloc({@required this.organsRepo}) : super(OrgansInitial()){
    add(FetchOrgans());
  }

  OrgansState get initialState => OrgansInitial();

  @override
  Stream<OrgansState> mapEventToState(
      OrgansEvent event
      ) async*{
    if(event is FetchOrgans){
      yield OrgansLoading();
      try{
        final List<OrgansModel> organsModel = await organsRepo.getOrgans();
        yield OrgansLoaded(organsModel);
      }catch(e){
        yield OrgansError();
        print(e.toString());
      }
    }
  }

}