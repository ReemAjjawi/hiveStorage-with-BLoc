import 'package:dio/dio.dart';
import 'package:first_homework_hive_sm/model/animal_model.dart';
import 'package:first_homework_hive_sm/model/handling.dart';
import 'package:hive/hive.dart';

abstract class Service {
  Dio dio = Dio();
  late Response response;
}

abstract class AnimalService extends Service {
  String baseurl = "https://664dcb37ede9a2b55654e96c.mockapi.io/api/v1/Animal";

  Future<ResultModel> getAnimal();
}

class AnimalServiceImp extends AnimalService {
  @override
  Future<ResultModel> getAnimal() async {
    try {
      response = await dio.get(baseurl);

      List<AnimalModel> animals = List.generate(
        response.data.length,
        (index) => AnimalModel.fromMap(response.data[index]),
      );

     
      return ListOf(data: animals);
    } catch (e) {
      return ExceptionModel();
    }
  }
}

