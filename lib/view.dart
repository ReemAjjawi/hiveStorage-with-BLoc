import 'package:first_homework_hive_sm/data/local/bloc/get_data_from_bloc.dart';
import 'package:first_homework_hive_sm/data/remote/bloc/animal_bloc.dart';
import 'package:first_homework_hive_sm/connection_status/bloc_network_.dart';
import 'package:first_homework_hive_sm/connection_status/state_network.dart';
import 'package:first_homework_hive_sm/data/remote/bloc/animal_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDataPage extends StatefulWidget {
  MyDataPage({super.key});

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    int i = 0;

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<GetDataFromBloc>().add(LoadMoretDataEvent(pageId: i++));
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetDataFromBloc()),
        BlocProvider(create: (context) => InternetBloc()),
        BlocProvider(create: (context) => AnimalBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is ConnectedState) {
              context.read<AnimalBloc>().add(GetRemotDataEvent());
            } else if (state is NotConnectedState) {
              context.read<GetDataFromBloc>().add(GetLocalDataEvent());
            }
          },
          child: BlocBuilder<AnimalBloc, AnimalState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AnimalListSuccess) {
                return ListView.builder(
                  itemCount: state.animals.length,
                  itemBuilder: (context, index) => ListTile(
                    //   leading: Image.network(state.animals[index].image),
                    title: Text(state.animals[index].name),
                  ),
                );
              } else if (state is ErrorState) {
                return Center(child: Text("error Loading Data ..."));
              }

              return BlocBuilder<GetDataFromBloc, GetDataFromState>(
                builder: (context, state) {
                  if (state is LocalStorageState) {
                    return ListView.builder(
                        controller: scrollController,
                        itemCount: state.Data.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.Data.length) {
                            return ListTile(
                             
                              //   leading: Image.network(state.animals[index].image),
                              title: Text(state.Data[index].name),
                            );
                          } else
                            return CircularProgressIndicator();
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
