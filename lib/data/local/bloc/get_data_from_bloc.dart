import 'package:bloc/bloc.dart';
import 'package:first_homework_hive_sm/data/remote/bloc/animal_bloc.dart';
import 'package:first_homework_hive_sm/model/handling.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../model/animal_model.dart';

part 'get_data_from_event.dart';
part 'get_data_from_state.dart';

class GetDataFromBloc extends Bloc<GetDataFromEvent, GetDataFromState> {
  late Box<List<AnimalModel>> box;
  List<AnimalModel> myList = [];

  GetDataFromBloc() : super(LoadingStateFrom()) {
    initialize();

    on<GetLocalDataEvent>((event, emit) async {
            print(" iam in load more data");

      if (myList.isNotEmpty) {
        emit(LocalStorageState(Data: myList));
      } else {
        emit(LocalStorageState(Data: []));
      }
    });

    on<LoadMoretDataEvent>((event, emit) async {
      print(" iam in load more data");
      final additionalItems = loadMoreData(event.pageId);
      myList.addAll(additionalItems);
      emit(LocalStorageState(
        Data: myList,
      ));
    });
  }

  Future<void> initialize() async {
    box = await Hive.openBox<List<AnimalModel>>('animals');
            print("iam in local");

            print(box.get('animals', defaultValue: []));

    final storedAnimals = await box.get('animals', defaultValue: []);
    
    if (storedAnimals != null && storedAnimals.isNotEmpty) {
      myList = (storedAnimals as List<AnimalModel>).take(10).toList();
      add(GetLocalDataEvent());
    }
  }

  List<AnimalModel> loadMoreData(int page) {
    final storedAnimals =
        box.get('animals', defaultValue: []) as List<AnimalModel>;
    final startIndex = page * 10;
    final endIndex = startIndex + 10;
    return storedAnimals.sublist(startIndex,
        endIndex > storedAnimals.length ? storedAnimals.length : endIndex);
  }
}
