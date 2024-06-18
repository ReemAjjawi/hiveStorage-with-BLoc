import 'package:first_homework_hive_sm/animal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'bloc/animal_bloc.dart';
import 'bloc/animal_event.dart';

void main() async {
  //Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();

  runApp(const MyApp());
  //Hive.registerAdapter(UserAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimalPageWithConsumer(),
    );
  }
}

@HiveType(typeId: 1)
class Person {
  Person({required this.name, required this.age, required this.friends});

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  List<String> friends;

  @override
  String toString() {
    return '$name: $age';
  }
}

class AnimalPageWithConsumer extends StatelessWidget {
  AnimalPageWithConsumer({super.key});

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnimalBloc()..add(GetAnimal()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: name,
              ),
            ),
            body: BlocConsumer<AnimalBloc, AnimalState>(
              listener: (context, state) {
                if (state is SuccessAnimalCreated) {
                  context.read<AnimalBloc>().add(GetAnimal());
                }
              },
              builder: (context, state) {
                if (state is AnimalListSuccess) {
                  return ListView.builder(
                    itemCount: state.animals.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Image.network(state.animals[index].image),
                      title: Text(state.animals[index].name),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              context.read<AnimalBloc>().add(CreateNewAnimal(name: name.text));
            }),
          );
        },
      ),
    );
  }
}
