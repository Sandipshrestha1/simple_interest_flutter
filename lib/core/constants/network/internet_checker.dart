import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker {
  final Connectivity _connectivity = Connectivity();

  /// Check current internet connection
  Future<bool> hasInternet() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    return await InternetConnection().hasInternetAccess;
  }

  /// Listen to internet changes
  Stream<bool> get internetStatusStream async* {
    yield await hasInternet();

    await for (final result in _connectivity.onConnectivityChanged) {
      if (result.contains(ConnectivityResult.none)) {
        yield false;
      } else {
        yield await InternetConnection().hasInternetAccess;
      }
    }
  }
}
