// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

abstract class LocationActionState extends LocationState{}

class LocationInitial extends LocationState {}
class LocationLoading extends LocationState{}

class SuccessState extends LocationState {
 final List<CurrentLocation> location;
  SuccessState({
    required this.location,
  });
}

class ErrorState extends LocationState {
  final String error;
  ErrorState({
    required this.error,
  });
}
