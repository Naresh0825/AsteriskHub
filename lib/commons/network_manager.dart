import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkControllerProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late bool isConnection;

  NetworkControllerProvider() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }

  ConnectivityResult connectivityResult = ConnectivityResult.none;

  String _pageText = 'Currently connected to no network. Please connect to a wifi network! or celluar network';

  ConnectivityResult get connectivity => connectivityResult;

  String get pageText => _pageText;

  void resultHandler(ConnectivityResult result) {
    connectivityResult = result;

    if (result == ConnectivityResult.none) {
      _pageText = 'Currently connected to no network. Please connect to a wifi network! or celluar network';
    } else if (result == ConnectivityResult.mobile) {
      _pageText = 'Currently connected to a celluar network. Please connect to a wifi network!';
    } else if (result == ConnectivityResult.wifi) {
      _pageText = 'Connected to a wifi network!';
    }
    notifyListeners();
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult = await (_connectivity.checkConnectivity());

    resultHandler(connectivityResult);
  }

  checkInternetConnection() async {
    for (int i = 1; i > 0; i++) {
      try {
        final result = await InternetAddress.lookup('www.google.com').timeout(const Duration(seconds: 8));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          isConnection = true;
        }
      } on TimeoutException catch (_) {
        isConnection = false;
      } on SocketException catch (_) {
        isConnection = false;
      }
    }
    notifyListeners();
  }
}
