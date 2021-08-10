import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

part 'connnectivity_state.dart';

class ConnnectivityCubit extends Cubit<ConnnectivityState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;
  ConnnectivityCubit(this.connectivity) : super(ConnnectivityInitial()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        print(connectivityResult.toString());
        emit(ConnnectivityConnected());
      } else {
        print(connectivityResult.toString());
        emit(ConnnectivityDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
