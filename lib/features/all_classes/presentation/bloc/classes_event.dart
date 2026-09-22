part of 'classes_bloc.dart';

@immutable
abstract class ClassesEvent extends Equatable {
  const ClassesEvent();
}

class GetAllClasses extends ClassesEvent {
  final int idClass;
  const GetAllClasses({required this.idClass});

  @override
  List<Object> get props => [idClass];
}