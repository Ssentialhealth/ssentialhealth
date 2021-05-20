import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellEvent.dart';
import 'package:pocket_health/bloc/adult_unwell/adultUnwellState.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/repository/adultUnwellRepo.dart';



class AdultUnwellBloc extends Bloc<AdultUnwellEvent,AdultUnwellState>{
  final AdultUnwellRepo adultUnwellRepo;
  AdultUnwellBloc({@required this.adultUnwellRepo}) : super(AdultUnwellInitial()){
    add(FetchConditions());
  }

  AdultUnwellState get initialState => AdultUnwellInitial();

  @override
  Stream<AdultUnwellState> mapEventToState(
      AdultUnwellEvent event
      ) async*{
    if(event is FetchConditions){
      yield AdultUnwellLoading();
      try{
        final List<SymptomModel> adultUnwellModel = await adultUnwellRepo.getConditions();
        yield AdultUnwellLoaded(adultUnwellModel);
      }catch(e){
        yield AdultUnwellError();
        print(e.toString());
      }
    }
  }

}