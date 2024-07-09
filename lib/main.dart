import 'dart:io';
import 'package:first_homework_hive_sm/model/animal_model.dart';
import 'package:first_homework_hive_sm/view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
      debugShowCheckedModeBanner: false,
      home: MyDataPage(),
    );
  }
}

// class AnimalPageWithConsumer extends StatefulWidget {
//   AnimalPageWithConsumer({super.key});

//   @override
//   State<AnimalPageWithConsumer> createState() => _AnimalPageWithConsumerState();
// }

// class _AnimalPageWithConsumerState extends State<AnimalPageWithConsumer> {
//   TextEditingController name = TextEditingController();



//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => AnimalBloc()..add(GetRemotDataEvent()),
//         ),
//         BlocProvider(
//           create: (context) => GetDataFromBloc(),
//         ),
//       ],
//       child: Builder(
//         builder: (context) {
//           return Scaffold(
//             appBar: AppBar(
//               title: TextField(
//                 controller: name,
//               ),
//             ),
//             body: BlocConsumer<AnimalBloc, AnimalState>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 if (state is AnimalListSuccess) {
//                   return ListView.builder(
//                     itemCount: state.animals.length,
//                     itemBuilder: (context, index) => ListTile(
//                       //   leading: Image.network(state.animals[index].image),
//                       title: Text(state.animals[index].name),
//                     ),
//                   );
                
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//             floatingActionButton: FloatingActionButton(onPressed: () {
//               context.read<AnimalBloc>().add(GetLocalDataEvent());
//             }),
//           );
//         },
//       ),
//     );
//   }
// }




