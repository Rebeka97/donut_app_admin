part of 'create_donut_bloc.dart';

sealed class CreateDonutState extends Equatable {
  const CreateDonutState();
  
  @override
  List<Object> get props => [];
}

final class CreateDonutInitial extends CreateDonutState {}

final class CreateDonutFailure extends CreateDonutState {}
final class CreateDonutLoading extends CreateDonutState {}
final class CreateDonutSuccess extends CreateDonutState {}