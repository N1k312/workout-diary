import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((results) {
    if (results.isEmpty) return false;
    return !results.every((r) => r == ConnectivityResult.none);
  }).asBroadcastStream();
});
