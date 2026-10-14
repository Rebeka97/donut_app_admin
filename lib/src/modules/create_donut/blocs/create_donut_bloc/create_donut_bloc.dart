import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:donut_repository/donut_repository.dart';

part 'create_donut_event.dart';
part 'create_donut_state.dart';

class CreateDonutBloc extends Bloc<CreateDonutEvent, CreateDonutState> {
  DonutRepo donutRepo;

  CreateDonutBloc(this.donutRepo) : super(CreateDonutInitial()) {
    on<CreateDonut>((event, emit) async {
      emit(CreateDonutLoading());
      try {
        await donutRepo.createDonut(event.donut);
        emit(CreateDonutSuccess());
      } catch (e) {
        emit(CreateDonutFailure());
      }
    });
  }
}