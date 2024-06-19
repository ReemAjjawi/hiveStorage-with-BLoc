import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:first_homework_hive_sm/animal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'bloc/animal_bloc.dart';
import 'bloc/animal_event.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AnimalModelAdapter());

  runApp(const MyApp());
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



// final List<ConnectivityResult> connectivityResult =
//       await (Connectivity().checkConnectivity());

// // This condition is for demo purposes only to explain every connection type.
// // Use conditions which work for your requirements.
//   if (connectivityResult.contains(ConnectivityResult.mobile)) {
//     print("mobile");
//     // Mobile network available.
//   } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
//     print("wifi");
//     // Wi-fi is available.
//     // Note for Android:
//     // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
//   } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
//     print("ethernet");
//     // Ethernet connection available.
//   } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
//     print("vpn");
//     // Vpn connection active.
//     // Note for iOS and macOS:
//     // There is no separate network interface type for [vpn].
//     // It returns [other] on any device (also simulator)
//   } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
//     print("bluetooth");
//     // Bluetooth connection available.
//   } else if (connectivityResult.contains(ConnectivityResult.other)) {
//     print("other");
//     // Connected to a network which is not in the above mentioned networks.
//   } else if (connectivityResult.contains(ConnectivityResult.none)) {
//     print("none");
//     // No available network types
//   }
//   checkInternetConnectivity();
