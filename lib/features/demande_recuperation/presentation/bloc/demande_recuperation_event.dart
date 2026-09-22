part of 'demande_recuperation_bloc.dart';

@immutable
abstract class DemandeRecuperationEvent extends Equatable {
  const DemandeRecuperationEvent();
}

class GetDemandesRecuperationsByIdClasse extends DemandeRecuperationEvent {
  final int idClass;
  const GetDemandesRecuperationsByIdClasse({required this.idClass});

  @override
  List<Object> get props => [idClass];
}