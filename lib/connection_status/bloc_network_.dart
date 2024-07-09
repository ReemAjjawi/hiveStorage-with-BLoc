import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:first_homework_hive_sm/connection_status/state_network.dart';
import 'package:meta/meta.dart';

import 'event_network.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? subscription;
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(ConnectedState(message: "Connected"));
      } else if (event is NotConnectedEvent) {
        emit(NotConnectedState(message: "Not Connected"));
      }
    });

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        print("hu");
        add(ConnectedEvent());
        print("hu2");
      } else {
        add(NotConnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    subscription!.cancel();
    return super.close();
  }
}
