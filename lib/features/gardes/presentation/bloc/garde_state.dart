part of 'garde_bloc.dart';

abstract class GardeState extends Equatable {
  const GardeState();
}

class GardeInitial extends GardeState {
  const GardeInitial();
  @override
  List<Object> get props => [];
}

class GardeLoading extends GardeState {
  const GardeLoading();
  @override
  List<Object> get props => [];
}

class GardeLoaded extends GardeState {
  final PersonneGardesModel model;
  const GardeLoaded({required this.model});

  @override
  List<Object> get props => [model];
}

class GardeError extends GardeState {
  final String message;
  const GardeError({required this.message});

  @override
  List<Object> get props => [message];
}