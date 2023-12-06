import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:locate_me/models/pastlocation.dart';
import 'package:locate_me/service/pastlocationservice.dart';
import 'package:meta/meta.dart';

part 'pastlocation_event.dart';
part 'pastlocation_state.dart';

class PastlocationBloc extends Bloc<PastlocationEvent, PastlocationState> {
  List<Pastlocations> pastloc =[];
  PastlocationBloc() : super(PastlocationInitial()) {
    on<InitialPastLocationEvent>(getpastlocationList);
  }

  FutureOr<void> getpastlocationList(InitialPastLocationEvent event, Emitter<PastlocationState> emit) async{
    emit(PastLocationLoading());
    try {
      var data = await PastLocationService.fetchLocation();
      pastloc = data;

      emit(SuccessStatePastLocation(pastloc: pastloc));
       
    } catch (e) {
    
    }
  }
}
