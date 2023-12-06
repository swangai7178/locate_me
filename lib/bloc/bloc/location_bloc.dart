import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:locate_me/models/currentlocationsmodel.dart';
import 'package:locate_me/service/locationservice.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  List<CurrentLocation> location=[];
  LocationBloc() : super(LocationInitial()) {
    on<InitialEvent>(initialevent);
  }

  FutureOr<void> initialevent(InitialEvent event, Emitter<LocationState> emit)async {
    emit(LocationLoading());

    try {
      
      var dataLocation =  await CustomerService.fetchLocation();

      location = dataLocation;
      emit(SuccessState(location: location));

    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
