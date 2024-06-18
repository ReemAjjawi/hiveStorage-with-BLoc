import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../animal_model.dart';
import '../animal_service.dart';
import '../handling.dart';
import 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  AnimalBloc() : super(AnimalInitial()) {
    //تابع من النت اول شي بعطيه حالة اللودينغ
    on<GetAnimal>((event, emit) async {
      emit(LoadingState());
      ResultModel response = await AnimalServiceImp().getAnimal();
      if (response is ListOf<AnimalModel>) {
        List<AnimalModel> animals = response.data;

        // (animals: response)); ليش مابعتنا بس ريسبونس وشو بصير لوو قلنا
        //   if (response is List <AnimalModel>) {
      } else {
        emit(ErrorState());
      }
    });

    on<CreateNewAnimal>(
      (event, emit) async {
        emit(LoadingState());
        // ! We Can Find The attribute of Event in the 'event' object
        ResultModel result =
            await AnimalServiceImp().createNewAniml(event.name);
        if (result is AnimalModel) {
          emit(SuccessAnimalCreated());
        } else {
          emit(ErrorState());
        }
      },
    );
  }
}
