import 'package:myinoface/features/gardes/domain/usecases/get_classes.dart';
import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';

part 'garde_event.dart';
part 'garde_state.dart';

class GardeBloc extends Bloc<GardeEvent, GardeState> {
  final GetPersonneGarde getPersonne;
  GardeBloc({required this.getPersonne}) : super(const GardeInitial()) {
    on<GardeEvent>((event, emit) async {
      if (event is GetPersonneGardeByDate) {
        try {
          emit(const GardeLoading());
          Either<Failure, PersonneGardesModel> either = await getPersonne.call(event.date);
          either.fold((failure) async {
            final messageFailure = either.fold((failure) => failure.props?.elementAt(0)?.toString() ?? '', (_) => '');
            logger.e('messageFailure: $messageFailure');
            emit(GardeError(message: messageFailure));
          }, (values) async {
            logger.d('values: $values');
            emit(GardeLoaded(model: values));
          });
        } catch(e) {
          return emit(GardeError(message: e.toString()));
        }
      }
    });
  }
}
