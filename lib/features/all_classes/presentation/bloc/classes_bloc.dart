import 'package:myinoface/features/all_classes/domain/usecases/get_classes.dart';
import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import 'package:myinoface/core/usecases/constants.dart';
import '../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {

  final GetClasses getClasses;

  ClassesBloc({required this.getClasses}) : super(const InitialClassesState()) {
    on<ClassesEvent>((event, emit) async {
      if (event is GetAllClasses) {
        try {
          emit(const LoadingClassesState());
          Either<Failure, EleveModel> either = await getClasses.call(event.idClass);
          either.fold((failure) async {
            final messageFailure = either.fold((failure) => (failure.props?.elementAt(0) ?? '') as String, (_) => '');
            logger.e('messageFailure: $messageFailure');
            emit(ErrorClassesState(message: messageFailure));
          }, (values) async {
            logger.d('values: $values');
            emit(LoadedClassesState(model: values));
          });
        } catch(e) {
          return emit(ErrorClassesState(message: e.toString()));
        }
      }
    });
  }
}
