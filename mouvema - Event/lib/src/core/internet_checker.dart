import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetChecker {
  Future<bool> isConnected();
}

class InternetCheckerImpl extends InternetChecker {
  @override
  Future<bool> isConnected() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
