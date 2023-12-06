// ignore_for_file: public_member_api_docs, sort_constructors_first




part of 'pastlocation_bloc.dart';

@immutable
abstract class PastlocationState {}

abstract class PastLocationActionState extends PastlocationState{}

class PastlocationInitial extends PastlocationState {}

class PastLocationLoading extends PastlocationState{}

class ErrorStatePast extends PastlocationState {
  final String error;
  ErrorStatePast({
    required this.error,
  });

  @override
  bool operator ==(covariant ErrorStatePast other) {
    if (identical(this, other)) return true;
  
    return 
      other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class SuccessStatePastLocation extends PastlocationState {
  final List<Pastlocations> pastloc;
  SuccessStatePastLocation({
    required this.pastloc,
  });

  
}


