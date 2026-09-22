import 'package:myinoface/features/demande_recuperation/domain/usecases/get_demande_recuperation.dart';
import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/core/usecases/constants.dart';
import '../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'demande_recuperation_event.dart';
part 'demande_recuperation_state.dart';

class DemandeRecuperationBloc extends Bloc<DemandeRecuperationEvent, DemandeRecuperationState> {

  final GetDemandeRecuperation getDemande;

  DemandeRecuperationBloc({required this.getDemande}) : super(const InitialDemandeRecuperationState()) {
    on<DemandeRecuperationEvent>((event, emit) async {
      if (event is GetDemandesRecuperationsByIdClasse) {
        try {
          Either<Failure, DemandeRecuperationModel> either = await getDemande.call(event.idClass);
          either.fold((failure) async {
            final messageFailure = either.fold((failure) => (failure.props.elementAt(0) as String?) ?? '', (_) => '');
            logger.e('messageFailure: $messageFailure');
            return emit(ErrorDemandeRecuperationState(message: messageFailure));
          }, (values) async {
            logger.d('values: $values');
            return emit(LoadedDemandeRecuperationState(model: values));
          });
        } catch(e) {
          return emit(ErrorDemandeRecuperationState(message: e.toString()));
        }
      }
    });
  }
}
