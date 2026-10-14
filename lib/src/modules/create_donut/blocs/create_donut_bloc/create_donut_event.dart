part of 'create_donut_bloc.dart';

sealed class CreateDonutEvent extends Equatable {
  const CreateDonutEvent();

  @override
  List<Object> get props => [];
}

class CreateDonut extends CreateDonutEvent {
  final Donut donut;

  const CreateDonut(this.donut);

  @override
  List<Object> get props => [donut];
}