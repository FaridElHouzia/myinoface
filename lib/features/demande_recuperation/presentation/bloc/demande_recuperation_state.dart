part of 'demande_recuperation_bloc.dart';

@immutable
abstract class DemandeRecuperationState extends Equatable {
  const DemandeRecuperationState();
}

class InitialDemandeRecuperationState extends DemandeRecuperationState {
  const InitialDemandeRecuperationState();

  @override
  List<Object> get props => [];
}

// class LoadingDemandeRecuperationState extends DemandeRecuperationState {
//   const LoadingDemandeRecuperationState();
//   @override
//   List<Object> get props => [];
// }

class LoadedDemandeRecuperationState extends DemandeRecuperationState {
  final DemandeRecuperationModel model;
  const LoadedDemandeRecuperationState({required this.model});

  @override
  List<Object> get props => [model];
}

class ErrorDemandeRecuperationState extends DemandeRecuperationState {
  final String message;
  const ErrorDemandeRecuperationState({required this.message});

  @override
  List<Object> get props => [message];
}