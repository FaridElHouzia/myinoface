part of 'classes_bloc.dart';

@immutable
abstract class ClassesState extends Equatable {
  const ClassesState();
}

class InitialClassesState extends ClassesState {
  const InitialClassesState();

  @override
  List<Object> get props => [];
}

class LoadingClassesState extends ClassesState {
  const LoadingClassesState();
  @override
  List<Object> get props => [];
}

class LoadedClassesState extends ClassesState {
  final EleveModel model;
  const LoadedClassesState({required this.model});

  @override
  List<Object> get props => [model];
}

class ErrorClassesState extends ClassesState {
  final String message;
  const ErrorClassesState({required this.message});

  @override
  List<Object> get props => [message];
}