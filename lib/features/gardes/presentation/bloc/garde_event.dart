part of 'garde_bloc.dart';

abstract class GardeEvent extends Equatable {
  const GardeEvent();
}


class GetPersonneGardeByDate extends GardeEvent {
  final DateTime date;
  const GetPersonneGardeByDate({required this.date});

  @override
  List<Object> get props => [date];
}