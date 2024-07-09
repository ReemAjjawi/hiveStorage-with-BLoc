import 'package:first_homework_hive_sm/service/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../model/animal_model.dart';
import '../../../model/handling.dart';
import 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  AnimalBloc() : super(AnimalInitial()) {
    late Box<List<AnimalModel>> box;
    on<GetRemotDataEvent>((event, emit) async {
      emit(LoadingState());

      ResultModel response = await AnimalServiceImp().getAnimal();
      if (response is ListOf<AnimalModel>) {
        List<AnimalModel> animals = response.data;

        box = await Hive.openBox<List<AnimalModel>>('animals');
        await box.put('animals', animals);
        print(box.get('animals', defaultValue: []));
        emit(AnimalListSuccess(animals: response.data));
      } else {
        emit(ErrorState());
      }
    });
  }
}
